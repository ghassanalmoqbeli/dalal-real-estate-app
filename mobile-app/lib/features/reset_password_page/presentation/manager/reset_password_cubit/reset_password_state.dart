part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {}

final class ResetPasswordFailure extends ResetPasswordState {
  final String errMsg;

  ResetPasswordFailure({required this.errMsg});
}

final class ResetPasswordSuccess extends ResetPasswordState {
  final RspAuth response;

  ResetPasswordSuccess({required this.response});
}
