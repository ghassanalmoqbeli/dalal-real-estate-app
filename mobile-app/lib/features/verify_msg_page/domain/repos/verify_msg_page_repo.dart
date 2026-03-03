import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/get_otp_resp_model.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/verify_model.dart';
import 'package:dartz/dartz.dart';

abstract class VerifyMsgPageRepo {
  Future<Either<Failure, RspAuth>> verifyOTPmsg(VerifyModel phone);
  Future<Either<Failure, RspAuth>> resendOTPmsg(String phone);
  Future<Either<Failure, GetOtpRespModel>> getOTPmsg(String phone);
}
