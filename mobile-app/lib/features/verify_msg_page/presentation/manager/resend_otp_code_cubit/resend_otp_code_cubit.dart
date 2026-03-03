import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/use_cases/resend_otp_msg_use_case.dart';
import 'package:meta/meta.dart';

part 'resend_otp_code_state.dart';

class ResendOtpCodeCubit extends Cubit<ResendOtpCodeState> {
  ResendOtpCodeCubit(this.resendOtpMsgUseCase) : super(ResendOtpCodeInitial());
  final ResendOtpMsgUseCase resendOtpMsgUseCase;
  Future<void> resendOtp(String phone) async {
    emit(ResendOtpCodeLoading());
    var result = await resendOtpMsgUseCase.call(phone);
    result.fold(
      (failure) {
        emit(ResendOtpCodeFailure(errMSg: failure.message));
      },
      (response) {
        if (response.status == 'success') {
          emit(ResendOtpCodeSuccess(response: response));
          return;
        }
        emit(
          ResendOtpCodeFailure(errMSg: response.message ?? 'An empty msg!!'),
        );
      },
    );
  }
}
