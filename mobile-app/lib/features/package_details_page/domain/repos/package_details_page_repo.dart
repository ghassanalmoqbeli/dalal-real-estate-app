import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_response_model.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class PackageDetailsPageRepo {
  Future<Either<Failure, PackageActivationResponse>> getPackageInfo(
    DeleteAdvReqModel idTokenModel,
  );
}
