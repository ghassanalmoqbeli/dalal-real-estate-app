part of 'verify_otp_code_cubit.dart';

@immutable
sealed class VerifyOtpCodeState {}

final class VerifyOtpCodeInitial extends VerifyOtpCodeState {}

final class VerifyOtpCodeLoading extends VerifyOtpCodeState {}

final class VerifyOtpCodeFailure extends VerifyOtpCodeState {
  final String errMsg;

  VerifyOtpCodeFailure({required this.errMsg});
}

final class VerifyOtpCodeSuccess extends VerifyOtpCodeState {
  final RspAuth response;

  VerifyOtpCodeSuccess({required this.response});
}
