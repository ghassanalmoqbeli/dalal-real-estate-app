import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_model.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_response_model.dart';
import 'package:dallal_proj/features/featuring_adv_page/domain/repos/featuring_adv_page_repo.dart';
import 'package:dartz/dartz.dart';

class FeatureTheAdvUseCase
    extends UseCase2<PackageActivationResponse, FeatureAdvModel> {
  final FeaturingAdvPageRepo featuringAdvPageRepo;

  FeatureTheAdvUseCase({required this.featuringAdvPageRepo});

  @override
  Future<Either<Failure, PackageActivationResponse>> call(
    FeatureAdvModel featureAdv,
  ) async {
    return await featuringAdvPageRepo.featureTheAdv(featureAdv);
  }
}
