import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_response_model.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/features/package_details_page/domain/repos/package_details_page_repo.dart';
import 'package:dartz/dartz.dart';

class GetPackageInfoUseCase
    extends UseCase2<PackageActivationResponse, DeleteAdvReqModel> {
  final PackageDetailsPageRepo packageDetailsPageRepo;

  GetPackageInfoUseCase({required this.packageDetailsPageRepo});
  @override
  Future<Either<Failure, PackageActivationResponse>> call(
    DeleteAdvReqModel idTokenModel,
  ) async {
    return await packageDetailsPageRepo.getPackageInfo(idTokenModel);
  }
}
