import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_model.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class FeaturingAdvPageRepo {
  Future<Either<Failure, PackageActivationResponse>> featureTheAdv(
    FeatureAdvModel featureAdv,
  );
}
