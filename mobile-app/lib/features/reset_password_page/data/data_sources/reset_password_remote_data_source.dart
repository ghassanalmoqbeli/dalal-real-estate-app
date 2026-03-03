import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';

abstract class ResetPasswordRemoteDataSource {
  Future<RspAuth> resetPass(LoginReqModel resetModel);
}

class ResetPasswordRemoteDataSourceImplement
    extends ResetPasswordRemoteDataSource {
  final Api api;

  ResetPasswordRemoteDataSourceImplement(this.api);
  @override
  Future<RspAuth> resetPass(LoginReqModel resetModel) async {
    try {
      var data = await api.post(
        url: "user/forgot_password.php",
        body: resetModel.toJson(),
        token: null,
      );
      RspAuth response = RspAuth.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
    // throw UnimplementedError();
  }
}
