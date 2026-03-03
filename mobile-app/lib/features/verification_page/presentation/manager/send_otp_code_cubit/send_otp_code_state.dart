part of 'send_otp_code_cubit.dart';

@immutable
sealed class SendOtpCodeState {}

final class SendOtpCodeInitial extends SendOtpCodeState {}

final class SendOtpCodeLoading extends SendOtpCodeState {}

final class SendOtpCodeFailure extends SendOtpCodeState {
  final String errMsg;

  SendOtpCodeFailure({required this.errMsg});
}

final class SendOtpCodeSuccess extends SendOtpCodeState {
  final RspAuth response;

  SendOtpCodeSuccess({required this.response});
}
