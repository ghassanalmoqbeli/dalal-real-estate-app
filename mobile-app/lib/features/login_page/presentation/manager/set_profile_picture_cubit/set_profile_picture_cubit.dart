import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/functions/update_me_data.dart';
import 'package:dallal_proj/features/login_page/data/models/set_profile_req_model.dart';
import 'package:dallal_proj/features/login_page/domain/use_cases/set_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'set_profile_picture_state.dart';

class SetProfileCubit extends Cubit<SetProfileState> {
  SetProfileCubit(this.setProfileUseCase) : super(SetProfileInitial());
  final SetProfileUseCase setProfileUseCase;

  Future<void> setProfile(UserProfileModel profileModel) async {
    emit(SetProfileLoading());

    var result = await setProfileUseCase.call(profileModel);

    result.fold(
      (failure) {
        emit(SetProfileFailure(errMsg: failure.message));
      },
      (profileModel) {
        if (isSuxes(profileModel.status)) {
          updateUserData(
            profileImage: profileModel.profileImage,
            name: profileModel.name,
            whatsapp: profileModel.whatsapp,
          );
          emit(SetProfileSuccess(profileModel: profileModel));
        } else {
          emit(
            SetProfileFailure(errMsg: profileModel.message ?? "Unknown error"),
          );
        }
      },
    );
  }
}
