import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dartz/dartz.dart';

abstract class VerificationPageRepo {
  // Future<Either<Failure, RspAuth>> getOTPcode(String phoneNumber);
  // Future<Either<Failure, RspAuth>> getOTPmsg(LoginModel loginModel);

  Future<Either<Failure, RspAuth>> resendOTPcode(String phoneNumber);
  //  Future<Either<Failure, RspAuth>> resendOTPmsg(LoginModel loginModel);
}
