import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/functions/update_me_data.dart';
import 'package:dallal_proj/features/login_page/data/models/set_profile_req_model.dart';
import 'package:dallal_proj/features/login_page/domain/use_cases/set_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'edit_personal_info_state.dart';

class EditPersonalInfoCubit extends Cubit<EditPersonalInfoState> {
  EditPersonalInfoCubit(this.editPersonalInfoUseCase)
    : super(EditPersonalInfoInitial());
  final SetProfileUseCase editPersonalInfoUseCase;

  Future<void> editPersonalInfo(UserProfileModel profileModel) async {
    emit(EditPersonalInfoLoading());

    var result = await editPersonalInfoUseCase.call(profileModel);

    result.fold(
      (failure) {
        emit(EditPersonalInfoFailure(errMsg: failure.message));
      },
      (profileModel) {
        if (isSuxes(profileModel.status)) {
          updateUserData(
            profileImage: profileModel.profileImage,
            name: profileModel.name,
            whatsapp: profileModel.whatsapp,
          );
          emit(EditPersonalInfoSuccess(profileModel: profileModel));
        } else {
          emit(
            EditPersonalInfoFailure(
              errMsg: profileModel.message ?? "Unknown error",
            ),
          );
        }
      },
    );
  }
  // Future<void> editPersonalInfo(UserProfileModel profileModel) async {
  //   emit(EditPersonalInfoLoading());

  //   var result = await SetProfileUseCase.call(profileModel);

  //   result.fold(
  //     (failure) {
  //       emit(EditPersonalInfoFailure(errMsg: failure.message));
  //     },
  //     (profileModel) {
  //       if (isSuxes(profileModel.status)) {
  //         updateUserData(
  //           profileImage: profileModel.profileImage,
  //           name: profileModel.name,
  //           whatsapp: profileModel.whatsapp,
  //         );
  //         emit(EditPersonalInfoSuccess(profileModel: profileModel));
  //       } else {
  //         emit(
  //           EditPersonalInfoFailure(errMsg: profileModel.message ?? "Unknown error"),
  //         );
  //       }
  //     },
  //   );
  // }
}
