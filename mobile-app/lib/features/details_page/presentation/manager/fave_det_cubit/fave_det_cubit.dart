import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/fave_adv_det_use_case.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/unfave_adv_det_use_case.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fave_det_state.dart';

// class FaveDetCubit extends Cubit<FaveDetState> {
//   FaveDetCubit() : super(FaveDetInitial());
// }

class FaveDetCubit extends Cubit<FaveDetState> {
  FaveDetCubit(this.faveAdvDetUseCase, this.unfaveAdvDetUseCase)
    : super(FaveDetInitial());
  final FaveAdvDetUseCase faveAdvDetUseCase;
  final UnfaveAdvDetUseCase unfaveAdvDetUseCase;

  // FaveCubit(this.faveAdvUseCase, this.unfaveAdvUseCase) : super(FaveInitial());

  Future<void> toggleFave(InteractionReqModel interAct, bool isFaved) async {
    emit(FaveDetLoading());
    final result =
        isFaved
            ? await unfaveAdvDetUseCase.call(interAct)
            : await faveAdvDetUseCase.call(interAct);

    result.fold((failure) => emit(FaveDetFailure(errMsg: failure.message)), (
      response,
    ) {
      if (isSuxes(response.status)) {
        emit(FaveDetSuccess(response: response, isFaved: !isFaved));
      } else {
        emit(FaveDetFailure(errMsg: response.message ?? 'Error'));
      }
    });
  }
}
