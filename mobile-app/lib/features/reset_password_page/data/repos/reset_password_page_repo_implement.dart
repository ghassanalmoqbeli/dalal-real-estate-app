import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/reset_password_page/data/data_sources/reset_password_remote_data_source.dart';
import 'package:dallal_proj/features/reset_password_page/domain/repos/reset_password_page_repo.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordPageRepoImplement extends ResetPasswordPageRepo {
  final ResetPasswordRemoteDataSource remoteDataSource;

  ResetPasswordPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, RspAuth>> resetPassword(
    LoginReqModel resetModel,
  ) async {
    try {
      var resetPass = await remoteDataSource.resetPass(resetModel);
      return right(resetPass);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
