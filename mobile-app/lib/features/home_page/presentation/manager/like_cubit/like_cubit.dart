import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/like_adv_use_case.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/unlike_adv_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'like_state.dart';

// class LikeCubit extends Cubit<LikeState> {
//   LikeCubit() : super(LikeInitial());
// }

class LikeCubit extends Cubit<LikeState> {
  LikeCubit(this.likeAdvUseCase, this.unlikeAdvUseCase) : super(LikeInitial());
  final LikeAdvUseCase likeAdvUseCase;
  final UnlikeAdvUseCase unlikeAdvUseCase;

  // LikeCubit(this.LikeAdvUseCase, this.unLikeAdvUseCase) : super(LikeInitial());

  Future<void> toggleLike(InteractionReqModel interAct, bool isLiked) async {
    emit(LikeLoading());
    final result =
        isLiked
            ? await unlikeAdvUseCase.call(interAct)
            : await likeAdvUseCase.call(interAct);

    result.fold((failure) => emit(LikeFailure(errMsg: failure.message)), (
      response,
    ) {
      if (isSuxes(response.status)) {
        emit(LikeSuccess(response: response, isLiked: !isLiked));
      } else {
        emit(LikeFailure(errMsg: response.message ?? 'Error'));
      }
    });
  }
}
