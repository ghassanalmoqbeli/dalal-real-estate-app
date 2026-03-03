import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_response_model.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/features/package_details_page/data/data_source/package_details_remote_data_source.dart';
import 'package:dallal_proj/features/package_details_page/domain/repos/package_details_page_repo.dart';
import 'package:dartz/dartz.dart';

class PackageDetailsPageRepoImplement extends PackageDetailsPageRepo {
  final PackageDetailsRemoteDataSource remoteDataSource;

  PackageDetailsPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, PackageActivationResponse>> getPackageInfo(
    DeleteAdvReqModel idTokenModel,
  ) async {
    try {
      var packageInfoRemote = await remoteDataSource.getPackageInfo(
        idTokenModel,
      );
      return right(packageInfoRemote);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
