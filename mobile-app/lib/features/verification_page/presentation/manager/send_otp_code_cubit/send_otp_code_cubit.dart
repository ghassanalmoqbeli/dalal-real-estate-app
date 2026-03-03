import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verification_page/Domain/use_cases/send_otp_code_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'send_otp_code_state.dart';

class SendOtpCodeCubit extends Cubit<SendOtpCodeState> {
  SendOtpCodeCubit(this.sendOtpCodeUseCase) : super(SendOtpCodeInitial());

  final SendOtpCodeUseCase sendOtpCodeUseCase;
  Future<void> sendOtpCode(String phone) async {
    emit(SendOtpCodeLoading());
    var result = await sendOtpCodeUseCase.call(phone);
    result.fold(
      (failure) {
        emit(SendOtpCodeFailure(errMsg: failure.message));
      },
      (response) {
        if (response.status == 'success') {
          emit(SendOtpCodeSuccess(response: response));
          return;
        }
        emit(
          SendOtpCodeFailure(
            errMsg: response.message ?? 'An Empty Response Message!!',
          ),
        );
      },
    );
  }
}
