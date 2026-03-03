part of 'ai_prediction_cubit.dart';

/// Base state for AI prediction
abstract class AiPredictionState {}

/// Initial state - no prediction requested yet
class AiPredictionInitial extends AiPredictionState {}

/// Loading state - prediction in progress
class AiPredictionLoading extends AiPredictionState {}

/// Success state - prediction completed successfully
class AiPredictionSuccess extends AiPredictionState {
  final PricePredictionResponseEntity response;
  final String currency;

  AiPredictionSuccess({required this.response, required this.currency});

  /// Get the price formatted for the selected currency
  String get formattedPrice => response.getFormattedPrice(currency);

  /// Get the raw price in the selected currency
  double get priceInCurrency => response.getPriceInCurrency(currency);

  /// Get the AI's explanation message
  String get message => response.message;

  /// Get the original price in YER
  double get originalPriceYER => response.predictedPrice;
}

/// Error state - prediction failed
class AiPredictionFailure extends AiPredictionState {
  final String errorMessage;

  AiPredictionFailure({required this.errorMessage});
}

/// Connection test state
class AiConnectionTesting extends AiPredictionState {}

/// Connection test result
class AiConnectionResult extends AiPredictionState {
  final bool isConnected;
  final String message;

  AiConnectionResult({required this.isConnected, required this.message});
}
