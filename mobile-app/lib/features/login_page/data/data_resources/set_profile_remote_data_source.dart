import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/features/login_page/data/models/set_profile_req_model.dart';

abstract class SetProfileRemoteDataSource {
  Future<UserProfileModel> setProfile(UserProfileModel profileModel);
}

class SetProfileRemoteDataSourceImplement extends SetProfileRemoteDataSource {
  final Api api;
  SetProfileRemoteDataSourceImplement({required this.api});
  @override
  Future<UserProfileModel> setProfile(UserProfileModel profileModel) async {
    try {
      var user = getMeData();
      Map<String, dynamic> body = {};
      if (profileModel.profileImage != null &&
          profileModel.profileImage!.isNotEmpty) {
        body.addAll({
          'profile_image': 'data:image/jpg;base64,${profileModel.profileImage}',
        });
      } else {
        body.addAll({'profile_image': user!.uProfileImage});
      }
      if (profileModel.name != null && profileModel.name!.isNotEmpty) {
        body.addAll({'name': profileModel.name});
      } else {
        body.addAll({'name': user!.uName});
      }
      if (profileModel.whatsapp != null && profileModel.whatsapp!.isNotEmpty) {
        body.addAll({'whatsapp': profileModel.whatsapp});
      } else {
        body.addAll({'whatsapp': user!.uWhatsapp ?? user.uPhone});
      }

      var data = await api.patch(
        url: 'user_profile/update_user_profile.php',
        body: body, //profileModel.toJson(),
        token: user!.uToken,
      );
      UserProfileModel response = UserProfileModel.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }
}
