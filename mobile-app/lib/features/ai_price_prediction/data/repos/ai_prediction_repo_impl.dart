import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/data_source/ai_prediction_remote_data_source.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/models/price_prediction_request_model.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_request_entity.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_response_entity.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/repos/ai_prediction_repo.dart';
import 'package:dartz/dartz.dart';

/// Implementation of the AI prediction repository.
class AiPredictionRepoImpl implements AiPredictionRepo {
  final AiPredictionRemoteDataSource remoteDataSource;

  AiPredictionRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PricePredictionResponseEntity>> predictPrice(
    PricePredictionRequestEntity request,
  ) async {
    try {
      // Convert entity to model
      final requestModel = PricePredictionRequestModel.fromEntity(request);

      // Call the remote data source
      final response = await remoteDataSource.predictPrice(requestModel);

      return right(response);
    } on Failure catch (f) {
      return left(f);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<bool> testConnection() async {
    return await remoteDataSource.testConnection();
  }
}
