part of 'edit_personal_info_cubit.dart';

@immutable
sealed class EditPersonalInfoState {}

final class EditPersonalInfoInitial extends EditPersonalInfoState {}

final class EditPersonalInfoLoading extends EditPersonalInfoState {}

final class EditPersonalInfoSuccess extends EditPersonalInfoState {
  final UserProfileModel profileModel;
  EditPersonalInfoSuccess({required this.profileModel});
}

final class EditPersonalInfoFailure extends EditPersonalInfoState {
  final String errMsg;
  EditPersonalInfoFailure({required this.errMsg});
}
