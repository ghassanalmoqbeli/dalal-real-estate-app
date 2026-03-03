part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {
  final RspAuth response;

  ChangePasswordSuccess({required this.response});
}

final class ChangePasswordFailure extends ChangePasswordState {
  final String error;

  ChangePasswordFailure({required this.error});
}
