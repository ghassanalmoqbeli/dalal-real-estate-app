import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dartz/dartz.dart';

abstract class MorePageRepo {
  Future<Either<Failure, RspAuth>> deleteAccount();
}
