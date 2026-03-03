import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/verify_model.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/use_cases/verify_otp_msg_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'verify_otp_code_state.dart';

class VerifyOtpCodeCubit extends Cubit<VerifyOtpCodeState> {
  VerifyOtpCodeCubit(this.verifyOtpMsgUseCase) : super(VerifyOtpCodeInitial());
  final VerifyOtpMsgUseCase verifyOtpMsgUseCase;
  Future<void> verifyOtp(VerifyModel verifyModel) async {
    emit(VerifyOtpCodeLoading());

    var result = await verifyOtpMsgUseCase.call(verifyModel);
    result.fold(
      (failure) {
        emit(VerifyOtpCodeFailure(errMsg: failure.message));
      },
      (response) {
        if (response.status == 'success') {
          emit(VerifyOtpCodeSuccess(response: response));
          return;
        }
        emit(
          VerifyOtpCodeFailure(errMsg: response.message ?? 'empty verifying!!'),
        );
      },
    );
  }
}
