import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/functions/save_user_data.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';
import 'package:dallal_proj/features/main_page/domain/use_cases/fetch_user_profile_use_case.dart';
import 'package:dallal_proj/features/my_account_page/data/models/user_profile/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this.fetchUserProfileUseCase) : super(UserProfileInitial());
  final FetchUserProfileUseCase fetchUserProfileUseCase;

  Future<void> fetchUserProfile(String? token) async {
    emit(UserProfileLoading());

    var result = await fetchUserProfileUseCase.call(token);
    result.fold(
      (failure) {
        emit(UserProfileFailure(errMsg: failure.message));
      },
      (userProfile) {
        if (isSuxes(userProfile.status)) {
          var user = getMeData();
          saveUserData(
            LoggedinUserEntity(
              uId: userProfile.data!.user!.id,
              uName: userProfile.data!.user!.name,
              uPhone: userProfile.data!.user!.phone,
              uProfileImage: userProfile.data?.user!.profileImage,
              uWhatsapp: userProfile.data!.user!.whatsapp,
              uToken: user!.uToken, // userProfile.data!.user!.token,
            ),
          );
          emit(UserProfileSuccess(userProfile: userProfile));
          return;
        } else if (token == null) {
          emit(UserProfileGuestMode());
          return;
        }
        emit(UserProfileFailure(errMsg: 'Not Connection Error'));
      },
    );
  }
}
