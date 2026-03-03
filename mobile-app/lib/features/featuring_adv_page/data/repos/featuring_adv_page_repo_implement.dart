import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/data_source/featuring_adv_remote_data_source.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_model.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_response_model.dart';
import 'package:dallal_proj/features/featuring_adv_page/domain/repos/featuring_adv_page_repo.dart';
import 'package:dartz/dartz.dart';

class FeaturingAdvPageRepoImplement extends FeaturingAdvPageRepo {
  final FeaturingAdvRemoteDataSource remoteDataSource;

  FeaturingAdvPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, PackageActivationResponse>> featureTheAdv(
    FeatureAdvModel featureAdv,
  ) async {
    try {
      var remoteFeatureTheAdv = await remoteDataSource.featureTheAdv(
        featureAdv,
      );
      return right(remoteFeatureTheAdv);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
