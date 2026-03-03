import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_request_entity.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_response_entity.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/repos/ai_prediction_repo.dart';
import 'package:dartz/dartz.dart';

/// Use case for predicting property price using AI
class PredictPriceUseCase
    extends
        UseCase2<PricePredictionResponseEntity, PricePredictionRequestEntity> {
  final AiPredictionRepo repo;

  PredictPriceUseCase({required this.repo});

  @override
  Future<Either<Failure, PricePredictionResponseEntity>> call(
    PricePredictionRequestEntity request,
  ) async {
    return await repo.predictPrice(request);
  }
}
