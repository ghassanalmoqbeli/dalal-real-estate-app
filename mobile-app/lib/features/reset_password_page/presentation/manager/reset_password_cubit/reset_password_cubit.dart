import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/reset_password_page/domain/use_cases/reset_password_use_case.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.resetPasswordUseCase) : super(ResetPasswordInitial());

  final ResetPasswordUseCase resetPasswordUseCase;
  Future<void> resetPassword(LoginReqModel resetModel) async {
    emit(ResetPasswordLoading());
    var result = await resetPasswordUseCase.call(resetModel);
    result.fold(
      (failure) {
        emit(ResetPasswordFailure(errMsg: failure.message));
      },
      (response) {
        if (response.status == 'success') {
          emit(ResetPasswordSuccess(response: response));
          return;
        }
        emit(
          ResetPasswordFailure(
            errMsg: response.message ?? 'An Empty Response Message!!',
          ),
        );
      },
    );
  }
}
