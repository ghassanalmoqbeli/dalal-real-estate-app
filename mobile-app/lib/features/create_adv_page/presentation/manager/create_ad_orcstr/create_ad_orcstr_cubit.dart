import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/domain/use_cases/craete_media_use_case.dart';
import 'package:dallal_proj/features/create_adv_page/domain/use_cases/create_adv_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'create_ad_orcstr_state.dart';

class CreateAdOrcstrCubit extends Cubit<CreateAdOrcstrState> {
  CreateAdOrcstrCubit({
    required this.createAdvUseCase,
    required this.createMediaUseCase,
  }) : super(const CreateAdOrcstrInitial());
  final CreateAdvUseCase createAdvUseCase;
  final CreateMediaUseCase createMediaUseCase;

  Future<void> createAdWithMedia(AdvertisementRequestModel request) async {
    emit(const CreateAdOrcstrLoading(step: 'Creating ad...'));

    final adResult = await createAdvUseCase.call(request);

    return adResult.fold(
      (failure) {
        emit(CreateAdOrcstrFailure(failure.message));
      },
      (adResponse) async {
        if (isSuxes(adResponse.status)) {
          final adId = adResponse.id;

          // Step 2: Upload media sequentially
          final mediaList = request.imagesBase64;
          final successfulMediaIds = <String>[];
          final failedMediaIds = <String>[];

          for (int i = 0; i < mediaList.length; i++) {
            emit(
              CreateAdOrcstrLoading(
                step: 'Uploading media...',
                currentMedia: i + 1,
                totalMedia: mediaList.length,
              ),
            );

            // try {
            final mediaResult = await createMediaUseCase.call(
              MediaReqModel(
                adId: adId,
                media64: mediaList[i],
                token: request.userToken,
              ),
            );

            mediaResult.fold(
              (failure) {
                failedMediaIds.add('${i + 1}');
                // Log error but continue with other media
                debugPrint(
                  'Failed to upload media ${i + 1} : ${failure.message}',
                );
              },
              (mediaResponse) {
                successfulMediaIds.add('${i + 1}');
              },
            );

            // Small delay to prevent rate limiting
            await Future.delayed(const Duration(milliseconds: 100));
          }

          // Step 3: Determine final state
          if (successfulMediaIds.isEmpty) {
            emit(
              const CreateAdOrcstrFailure(
                'Ad created but failed to upload all media',
              ),
            );
          } else if (failedMediaIds.isNotEmpty) {
            emit(
              CreateAdOrcstrPartialSuccess(
                adId: adId,
                successfulMediaIds: successfulMediaIds,
                failedMediaIds: failedMediaIds,
                message:
                    'Ad created with ${failedMediaIds.length} out of ${mediaList.length} failed media uploads',
              ),
            );
          } else {
            emit(
              CreateAdOrcstrSuccess(
                adId: adId,
                successfulMediaIds: successfulMediaIds,
              ),
            );
          }
        } else {
          emit(
            const CreateAdOrcstrFailure(
              'Unknown Error: Maybe Connection Error Or Token, isnt it?',
            ),
          );
        }
      },
    );
  }
}
