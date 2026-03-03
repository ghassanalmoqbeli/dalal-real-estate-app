import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/change_password_page/data/models/change_pass_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChangePasswordPageRepo {
  Future<Either<Failure, RspAuth>> changePassword(
    ChangePassReqModel changePassModel,
  );
}
