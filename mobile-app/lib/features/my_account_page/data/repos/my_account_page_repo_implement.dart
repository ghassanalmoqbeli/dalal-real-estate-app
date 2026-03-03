import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/my_account_page/data/data_source/my_account_remote_data_source.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/features/my_account_page/domain/repos/my_account_page_repo.dart';
import 'package:dartz/dartz.dart';

class MyAccountPageRepoImplement extends MyAccountPageRepo {
  final MyAccountRemoteDataSource remoteDataSource;

  MyAccountPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, RspAuth>> deleteAdv(
    DeleteAdvReqModel deleteAdvReqModel,
  ) async {
    try {
      var response = await remoteDataSource.deleteAdv(deleteAdvReqModel);
      return right(response);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
