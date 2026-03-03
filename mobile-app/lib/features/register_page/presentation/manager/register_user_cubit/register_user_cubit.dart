import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/register_page/data/models/register_model.dart';
import 'package:dallal_proj/features/register_page/domain/use_cases/register_user_use_case.dart';
import 'package:meta/meta.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit(this.registerUserUseCase) : super(RegisterUserInitial());

  final RegisterUserUseCase registerUserUseCase;

  Future<void> registerUser(RegisterModel registerModel) async {
    emit(RegisterUserLoading());

    var result = await registerUserUseCase.call(registerModel);
    result.fold(
      (failure) {
        emit(RegisterUserFailure(errMsg: failure.message));
      },
      (response) {
        if (response.status == 'success') {
          emit(RegisterUserSuccess(response: response));
          return;
        }
        emit(
          RegisterUserFailure(
            errMsg: response.message ?? 'An Empty Log Message!',
          ),
        );
      },
    );
  }
}
