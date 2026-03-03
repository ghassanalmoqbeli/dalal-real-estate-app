import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/more_page/domain/use_cases/delete_accout_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this.deleteAccountUseCase) : super(DeleteAccountInitial());
  final DeleteAccountUseCase deleteAccountUseCase;

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());

    var result = await deleteAccountUseCase.call();
    result.fold(
      (failure) => emit(DeleteAccountFailure(errMsg: failure.message)),
      (response) {
        if (isSuxes(response.status)) {
          emit(DeleteAccountSuccess(response: response));
        } else {
          emit(
            DeleteAccountFailure(
              errMsg: '${response.status} : ${response.message}',
            ),
          );
        }
      },
    );
  }
}
