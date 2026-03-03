import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_request_entity.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_response_entity.dart';
import 'package:dartz/dartz.dart';

/// Abstract repository for AI price prediction.
/// This defines the contract that the data layer must implement.
abstract class AiPredictionRepo {
  /// Predicts the property price using AI model
  ///
  /// Returns [Right] with [PricePredictionResponseEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PricePredictionResponseEntity>> predictPrice(
    PricePredictionRequestEntity request,
  );

  /// Tests if the AI server is reachable
  Future<bool> testConnection();
}
