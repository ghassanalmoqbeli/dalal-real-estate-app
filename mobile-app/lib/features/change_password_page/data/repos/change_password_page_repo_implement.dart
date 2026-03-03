import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/change_password_page/data/data_source/change_password_remote_data_source.dart';
import 'package:dallal_proj/features/change_password_page/data/models/change_pass_req_model.dart';
import 'package:dallal_proj/features/change_password_page/domain/repos/change_password_page_repo.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordPageRepoImplement extends ChangePasswordPageRepo {
  final ChangePasswordRemoteDataSource remoteDataSource;

  ChangePasswordPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, RspAuth>> changePassword(
    ChangePassReqModel changePassModel,
  ) async {
    try {
      var response = await remoteDataSource.changePassword(changePassModel);
      return right(response);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
