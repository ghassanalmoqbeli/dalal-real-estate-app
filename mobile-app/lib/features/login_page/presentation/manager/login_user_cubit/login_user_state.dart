part of 'login_user_cubit.dart';

@immutable
sealed class LoginUserState {}

final class LoginUserInitial extends LoginUserState {}

final class LoginUserLoading extends LoginUserState {}

final class LoginUserFailure extends LoginUserState {
  final String errMsg;

  LoginUserFailure({required this.errMsg});
}

final class LoginUserSuccess extends LoginUserState {
  final LoggedinUserEntity loggedUserEntiy;

  LoginUserSuccess({required this.loggedUserEntiy});
}

final class LoginUserUnVerified extends LoginUserState {
  final String errMsg;

  LoginUserUnVerified({required this.errMsg});
}
