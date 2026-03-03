part of 'resend_otp_code_cubit.dart';

@immutable
sealed class ResendOtpCodeState {}

final class ResendOtpCodeInitial extends ResendOtpCodeState {}

final class ResendOtpCodeLoading extends ResendOtpCodeState {}

final class ResendOtpCodeFailure extends ResendOtpCodeState {
  final String errMSg;

  ResendOtpCodeFailure({required this.errMSg});
}

final class ResendOtpCodeSuccess extends ResendOtpCodeState {
  final RspAuth response;

  ResendOtpCodeSuccess({required this.response});
}
