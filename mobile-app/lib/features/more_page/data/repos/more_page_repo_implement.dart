import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/more_page/data/data_source/more_remote_data_source.dart';
import 'package:dallal_proj/features/more_page/domain/repos/more_page_repo.dart';
import 'package:dartz/dartz.dart';

class MorePageRepoImplement extends MorePageRepo {
  final MoreRemoteDataSource remoteDataSource;

  MorePageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, RspAuth>> deleteAccount() async {
    try {
      var deleteAccountRemote = await remoteDataSource.deleteAccount();
      // RspAuth response = RspAuth.fromJson(deleteAccountRemote);
      return right(deleteAccountRemote);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
