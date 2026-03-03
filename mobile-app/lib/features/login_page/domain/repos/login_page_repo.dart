import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/login_page/data/models/login_response_model/login_rsp_model.dart';
import 'package:dartz/dartz.dart';

abstract class LoginPageRepo {
  Future<Either<Failure, LoginRspModel>> loginUser(LoginReqModel loginModel);
}
