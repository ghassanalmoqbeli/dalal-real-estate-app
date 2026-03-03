import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/use_cases/get_otp_msg_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'get_otp_code_state.dart';

class GetOtpCodeCubit extends Cubit<GetOtpCodeState> {
  GetOtpCodeCubit(this.getOtpMsgUseCase) : super(GetOtpCodeInitial());

  final GetOtpMsgUseCase getOtpMsgUseCase;

  Future<void> getOtpCodeMsg(String phone) async {
    emit(GetOtpCodeLoading());
    var result = await getOtpMsgUseCase.call(phone);
    result.fold(
      (failure) {
        emit(GetOtpCodeFailure(errMsg: failure.message));
      },
      (otpRspMsg) {
        if (isSuxes(otpRspMsg.otpStatus) && isNemp(otpRspMsg.otpCode)) {
          emit(GetOtpCodeSuccess(otpCode: otpRspMsg.otpCode!));
          return;
        }
        emit(
          GetOtpCodeFailure(
            errMsg: otpRspMsg.otpMessage ?? 'An Empty OTP Message!!',
          ),
        );
      },
    );
  }
}
