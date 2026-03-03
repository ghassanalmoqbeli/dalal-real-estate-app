import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';
import 'package:dallal_proj/features/login_page/domain/use_cases/login_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  LoginUserCubit(this.loginUserUseCase) : super(LoginUserInitial());

  final LoginUserUseCase loginUserUseCase;

  Future<void> loginUser(LoginReqModel loginReqModel) async {
    emit(LoginUserLoading());

    var result = await loginUserUseCase.call(loginReqModel);
    result.fold(
      (failure) {
        emit(LoginUserFailure(errMsg: failure.message));
      },
      (loginRspModel) {
        if (isSuxes(loginRspModel.logStatus)) {
          emit(LoginUserSuccess(loggedUserEntiy: loginRspModel.userData!));
          return;
        }
        if (loginRspModel.verified != null && loginRspModel.verified == true) {
          emit(
            LoginUserUnVerified(
              errMsg: loginRspModel.logMessage ?? 'unverified',
            ),
          );
        }
        emit(
          LoginUserFailure(
            errMsg: loginRspModel.logMessage ?? 'Empty Log Message!',
          ),
        );
      },
    );
  }
}
