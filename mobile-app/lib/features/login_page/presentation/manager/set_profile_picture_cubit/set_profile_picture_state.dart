part of 'set_profile_picture_cubit.dart';

@immutable
sealed class SetProfileState {}

final class SetProfileInitial extends SetProfileState {}

final class SetProfileLoading extends SetProfileState {}

final class SetProfileSuccess extends SetProfileState {
  final UserProfileModel profileModel;
  SetProfileSuccess({required this.profileModel});
}

final class SetProfileFailure extends SetProfileState {
  final String errMsg;
  SetProfileFailure({required this.errMsg});
}
