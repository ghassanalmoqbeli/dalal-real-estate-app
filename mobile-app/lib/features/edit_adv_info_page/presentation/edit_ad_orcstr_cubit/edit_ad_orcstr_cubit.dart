import 'package:flutter/material.dart';
import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/models/edit_advertisement_request_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/delete_media_params.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/delete_media_use_case.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/update_adv_use_case.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/update_media_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'edit_ad_orcstr_state.dart';

class EditAdOrcstrCubit extends Cubit<EditAdOrcstrState> {
  EditAdOrcstrCubit({
    required this.updateAdvUseCase,
    required this.updateMediaUseCase,
    required this.deleteMediaUseCase,
  }) : super(const EditAdOrcstrInitial());

  final UpdateAdvUseCase updateAdvUseCase;
  final UpdateMediaUseCase updateMediaUseCase;
  final DeleteMediaUseCase deleteMediaUseCase;

  /// Main orchestration method for editing an ad
  /// [request] - The updated ad info
  /// [mediaIdsToDelete] - List of existing media IDs to delete
  /// [newMediaBase64List] - List of new media (base64) to add
  /// [token] - User authentication token
  Future<void> editAdWithMedia({
    required EditAdvertisementRequestModel request,
    required List<int> mediaIdsToDelete,
    required List<String> newMediaBase64List,
    required String token,
  }) async {
    // Step 1: Update ad info
    emit(const EditAdOrcstrLoading(step: 'Updating ad info...'));

    final adResult = await updateAdvUseCase.call(request);

    return adResult.fold(
      (failure) {
        emit(EditAdOrcstrFailure(failure.message));
      },
      (adResponse) async {
        if (isSuxes(adResponse.status)) {
          final adId = request.advertisementId;

          final deletedMediaIds = <int>[];
          final failedDeleteMediaIds = <int>[];
          final successfulNewMediaIds = <String>[];
          final failedNewMediaIds = <String>[];

          // Step 2: Delete media that user removed
          if (mediaIdsToDelete.isNotEmpty) {
            for (int i = 0; i < mediaIdsToDelete.length; i++) {
              emit(
                EditAdOrcstrLoading(
                  step: 'Deleting media...',
                  currentMedia: i + 1,
                  totalMedia: mediaIdsToDelete.length,
                ),
              );

              final deleteResult = await deleteMediaUseCase.call(
                DeleteMediaParams(
                  mediaId: mediaIdsToDelete[i],
                  token: token,
                ),
              );

              deleteResult.fold(
                (failure) {
                  failedDeleteMediaIds.add(mediaIdsToDelete[i]);
                  debugPrint(
                    'Failed to delete media ${mediaIdsToDelete[i]}: ${failure.message}',
                  );
                },
                (response) {
                  deletedMediaIds.add(mediaIdsToDelete[i]);
                },
              );

              await Future.delayed(const Duration(milliseconds: 100));
            }
          }

          // Step 3: Upload new media
          if (newMediaBase64List.isNotEmpty) {
            for (int i = 0; i < newMediaBase64List.length; i++) {
              emit(
                EditAdOrcstrLoading(
                  step: 'Uploading new media...',
                  currentMedia: i + 1,
                  totalMedia: newMediaBase64List.length,
                ),
              );

              final mediaResult = await updateMediaUseCase.call(
                MediaReqModel(
                  adId: adId,
                  media64: newMediaBase64List[i],
                  token: token,
                ),
              );

              mediaResult.fold(
                (failure) {
                  failedNewMediaIds.add('${i + 1}');
                  debugPrint(
                    'Failed to upload new media ${i + 1}: ${failure.message}',
                  );
                },
                (response) {
                  successfulNewMediaIds.add('${i + 1}');
                },
              );

              await Future.delayed(const Duration(milliseconds: 100));
            }
          }

          // Step 4: Determine final state
          final hasDeleteFailures = failedDeleteMediaIds.isNotEmpty;
          final hasUploadFailures = failedNewMediaIds.isNotEmpty;

          if (hasDeleteFailures || hasUploadFailures) {
            emit(
              EditAdOrcstrPartialSuccess(
                adId: adId,
                deletedMediaIds: deletedMediaIds,
                failedDeleteMediaIds: failedDeleteMediaIds,
                successfulNewMediaIds: successfulNewMediaIds,
                failedNewMediaIds: failedNewMediaIds,
                message: _buildPartialSuccessMessage(
                  failedDeleteMediaIds,
                  failedNewMediaIds,
                ),
              ),
            );
          } else {
            emit(
              EditAdOrcstrSuccess(
                adId: adId,
                deletedMediaIds: deletedMediaIds,
                successfulNewMediaIds: successfulNewMediaIds,
              ),
            );
          }
        } else {
          emit(
            EditAdOrcstrFailure(
              adResponse.message.isNotEmpty
                  ? adResponse.message
                  : 'Failed to update ad. Please try again.',
            ),
          );
        }
      },
    );
  }

  /// Helper method to build partial success message
  String _buildPartialSuccessMessage(
    List<int> failedDeleteIds,
    List<String> failedUploadIds,
  ) {
    final messages = <String>[];
    if (failedDeleteIds.isNotEmpty) {
      messages.add('${failedDeleteIds.length} media failed to delete');
    }
    if (failedUploadIds.isNotEmpty) {
      messages.add('${failedUploadIds.length} new media failed to upload');
    }
    return 'Ad updated but: ${messages.join(', ')}';
  }

  /// Method for updating only ad info (without media changes)
  Future<void> updateAdInfoOnly(EditAdvertisementRequestModel request) async {
    emit(const EditAdOrcstrLoading(step: 'Updating ad info...'));

    final result = await updateAdvUseCase.call(request);

    result.fold(
      (failure) => emit(EditAdOrcstrFailure(failure.message)),
      (response) {
        if (isSuxes(response.status)) {
          emit(
            EditAdOrcstrSuccess(
              adId: request.advertisementId,
              deletedMediaIds: const [],
              successfulNewMediaIds: const [],
            ),
          );
        } else {
          emit(
            EditAdOrcstrFailure(
              response.message.isNotEmpty
                  ? response.message
                  : 'Failed to update ad.',
            ),
          );
        }
      },
    );
  }
}

