import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/like_adv_det_use_case.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/unlike_adv_det_use_case.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'like_det_state.dart';

// class LikeDetCubit extends Cubit<LikeDetState> {
//   LikeDetCubit() : super(LikeDetInitial());
// }

class LikeDetCubit extends Cubit<LikeDetState> {
  LikeDetCubit(this.likeAdvDetUseCase, this.unlikeAdvDetUseCase)
    : super(LikeDetInitial());
  final LikeAdvDetUseCase likeAdvDetUseCase;
  final UnlikeAdvDetUseCase unlikeAdvDetUseCase;

  // LikeCubit(this.LikeAdvUseCase, this.unLikeAdvUseCase) : super(LikeInitial());

  Future<void> toggleLike(InteractionReqModel interAct, bool isLiked) async {
    emit(LikeDetLoading());
    final result =
        isLiked
            ? await unlikeAdvDetUseCase.call(interAct)
            : await likeAdvDetUseCase.call(interAct);

    result.fold((failure) => emit(LikeDetFailure(errMsg: failure.message)), (
      response,
    ) {
      if (isSuxes(response.status)) {
        emit(LikeDetSuccess(response: response, isLiked: !isLiked));
      } else {
        emit(LikeDetFailure(errMsg: response.message ?? 'Error'));
      }
    });
  }
}
