import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verify_msg_page/data/data_resources/verify_msg_remote_data_source.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/get_otp_resp_model.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/verify_model.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/repos/verify_msg_page_repo.dart';
import 'package:dartz/dartz.dart';

class VerifyMsgPageRepoImplement extends VerifyMsgPageRepo {
  final VerifyMsgRemoteDataSource remoteDataSource;

  VerifyMsgPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, GetOtpRespModel>> getOTPmsg(String phone) async {
    try {
      var getCode = await remoteDataSource.getMsg(phone);
      return right(getCode);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> resendOTPmsg(String phone) async {
    try {
      var resendCode = await remoteDataSource.resendMsg(phone);
      return right(resendCode);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> verifyOTPmsg(VerifyModel phone) async {
    try {
      var verifyCode = await remoteDataSource.verifyMsg(phone);
      return right(verifyCode);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
