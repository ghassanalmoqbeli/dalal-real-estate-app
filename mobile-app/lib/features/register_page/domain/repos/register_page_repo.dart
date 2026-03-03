import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/register_page/data/models/register_model.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterPageRepo {
  Future<Either<Failure, RspAuth>> registerUser(RegisterModel regUser);
}
