import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class ResetPasswordPageRepo {
  Future<Either<Failure, RspAuth>> resetPassword(LoginReqModel resetModel);
}
