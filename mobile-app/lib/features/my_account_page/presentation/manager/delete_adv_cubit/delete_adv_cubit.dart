import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/features/my_account_page/domain/use_cases/delete_adv_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'delete_adv_state.dart';

class DeleteAdvCubit extends Cubit<DeleteAdvState> {
  DeleteAdvCubit(this.deleteAdvUseCase) : super(DeleteAdvInitial());
  final DeleteAdvUseCase deleteAdvUseCase;

  Future<void> deleteAdv(DeleteAdvReqModel deleteAdvReqModel) async {
    emit(DeleteAdvLoading());

    var result = await deleteAdvUseCase.call(deleteAdvReqModel);

    result.fold((failure) => emit(DeleteAdvFailure(errMsg: failure.message)), (
      response,
    ) {
      if (isSuxes(response.status)) {
        emit(DeleteAdvSuccess(response: response));
        return;
      }
      emit(
        DeleteAdvFailure(errMsg: '${response.status} : ${response.message}'),
      );
      return;
    });
  }
}
