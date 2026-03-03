part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileGuestMode extends UserProfileState {}

final class UserProfileSuccess extends UserProfileState {
  final UserProfile userProfile;

  UserProfileSuccess({required this.userProfile});
}

final class UserProfileFailure extends UserProfileState {
  final String errMsg;

  UserProfileFailure({required this.errMsg});
}
