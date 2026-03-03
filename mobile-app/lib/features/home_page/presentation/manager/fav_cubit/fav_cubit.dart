import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/fave_adv_use_case.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/unfave_adv_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fav_state.dart';

// class FavCubit extends Cubit<FavCubitState> {
// }
class FaveCubit extends Cubit<FaveState> {
  FaveCubit(this.faveAdvUseCase, this.unfaveAdvUseCase) : super(FaveInitial());
  final FaveAdvUseCase faveAdvUseCase;
  final UnfaveAdvUseCase unfaveAdvUseCase;

  // FaveCubit(this.faveAdvUseCase, this.unfaveAdvUseCase) : super(FaveInitial());

  Future<void> toggleFave(InteractionReqModel interAct, bool isFaved) async {
    emit(FaveLoading());
    final result =
        isFaved
            ? await unfaveAdvUseCase.call(interAct)
            : await faveAdvUseCase.call(interAct);

    result.fold((failure) => emit(FaveFailure(errMsg: failure.message)), (
      response,
    ) {
      if (isSuxes(response.status)) {
        emit(
          FaveSuccess(
            response: response,
            isFaved: !isFaved,
            token: interAct.token!,
          ),
        );
      } else {
        emit(FaveFailure(errMsg: response.message ?? 'Error'));
      }
    });
  }
}
