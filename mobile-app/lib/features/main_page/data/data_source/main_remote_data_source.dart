import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/features/my_account_page/data/models/user_profile/user_profile.dart';

abstract class MainRemoteDataSource {
  Future<UserProfile> getUserProfileData(String? token);
}

class MainRemoteDataSourceImplement extends MainRemoteDataSource {
  final Api api;

  MainRemoteDataSourceImplement({required this.api});

  @override
  Future<UserProfile> getUserProfileData(String? token) async {
    try {
      var data = await api.get(
        url: "user_profile/get_user_profile.php",
        token: token,
      );
      UserProfile response = UserProfile.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }
}
