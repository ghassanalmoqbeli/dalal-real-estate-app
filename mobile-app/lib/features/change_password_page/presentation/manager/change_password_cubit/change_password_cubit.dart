import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/change_password_page/data/models/change_pass_req_model.dart';
import 'package:dallal_proj/features/change_password_page/domain/use_cases/change_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.changePasswordUseCase)
    : super(ChangePasswordInitial());
  final ChangePasswordUseCase changePasswordUseCase;

  Future<void> changePassword(ChangePassReqModel changePassModel) async {
    emit(ChangePasswordLoading());

    var result = await changePasswordUseCase.call(changePassModel);

    result.fold(
      (failure) => emit(ChangePasswordFailure(error: failure.message)),
      (response) {
        if (isSuxes(response.status)) {
          emit(ChangePasswordSuccess(response: response));
          return;
        } else {
          emit(
            ChangePasswordFailure(
              error: '${response.status} : ${response.message}',
            ),
          );
        }
      },
    );
  }
}
