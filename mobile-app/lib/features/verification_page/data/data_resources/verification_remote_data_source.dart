import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';

abstract class VerificationRemoteDataSource {
  Future<RspAuth> resendMsg(String phone);
  // Future<RspAuth> getMsg(String phone);
}

class VerificationRemoteDataSourceImplement
    extends VerificationRemoteDataSource {
  final Api api;

  VerificationRemoteDataSourceImplement(this.api);
  // @override
  // Future<RspAuth> getMsg(String phone) async {
  //   var data = await api.post(
  //     url: "user/get_otp.php",
  //     body: {"phone": phone},
  //     token: null,
  //   );
  //   RspAuth response = RspAuth.fromJson(data);
  //   return response;
  //   // throw UnimplementedError();
  // }

  @override
  Future<RspAuth> resendMsg(String phone) async {
    try {
      var data = await api.post(
        url: "user/resend_otp_code.php",
        body: {"phone": phone},
        token: null,
      );
      RspAuth response = RspAuth.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }
}
