part of 'get_otp_code_cubit.dart';

@immutable
sealed class GetOtpCodeState {}

final class GetOtpCodeInitial extends GetOtpCodeState {}

final class GetOtpCodeLoading extends GetOtpCodeState {}

final class GetOtpCodeFailure extends GetOtpCodeState {
  final String errMsg;

  GetOtpCodeFailure({required this.errMsg});
}

final class GetOtpCodeSuccess extends GetOtpCodeState {
  final String otpCode;

  GetOtpCodeSuccess({required this.otpCode});
}
