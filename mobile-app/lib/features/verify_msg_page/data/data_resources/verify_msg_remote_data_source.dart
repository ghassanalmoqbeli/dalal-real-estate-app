import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/get_otp_resp_model.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/verify_model.dart';

abstract class VerifyMsgRemoteDataSource {
  Future<RspAuth> verifyMsg(VerifyModel verifyModel);
  Future<RspAuth> resendMsg(String phone);
  Future<GetOtpRespModel> getMsg(String phone);
}

class VerifyMsgRemoteDataSourceImplement extends VerifyMsgRemoteDataSource {
  final Api api;

  VerifyMsgRemoteDataSourceImplement(this.api);
  @override
  Future<GetOtpRespModel> getMsg(String phone) async {
    try {
      var data = await api.post(
        url: "user/get_otp.php",
        body: {"phone": phone},
        token: null,
      );
      GetOtpRespModel response = GetOtpRespModel.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }

    // throw UnimplementedError();
  }

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

  @override
  Future<RspAuth> verifyMsg(VerifyModel verifyModel) async {
    try {
      var data = await api.post(
        url: "user/verify_otp.php",
        body: verifyModel.toJson(),
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
