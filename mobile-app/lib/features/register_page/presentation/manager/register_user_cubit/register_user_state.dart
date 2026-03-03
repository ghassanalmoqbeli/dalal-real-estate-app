part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState {}

final class RegisterUserInitial extends RegisterUserState {}

final class RegisterUserLoading extends RegisterUserState {}

final class RegisterUserFailure extends RegisterUserState {
  final String errMsg;

  RegisterUserFailure({required this.errMsg});
}

final class RegisterUserSuccess extends RegisterUserState {
  final RspAuth response;

  RegisterUserSuccess({required this.response});
}
