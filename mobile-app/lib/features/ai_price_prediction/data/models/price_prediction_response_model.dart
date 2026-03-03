import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_response_entity.dart';

/// Data model for the AI price prediction response.
///
/// The AI model returns the following format:
/// ```json
/// {
///   "predicted_price": 150000,
///   "message": "العقار يقع في منطقة قريبة من الخدمات والطرق الرئيسية لكنها غير مصنفة كحي راقٍ."
/// }
/// ```
class PricePredictionResponseModel extends PricePredictionResponseEntity {
  const PricePredictionResponseModel({
    required super.predictedPrice,
    required super.message,
  });

  /// Creates a model from JSON response
  factory PricePredictionResponseModel.fromJson(Map<String, dynamic> json) {
    // Handle null or missing predicted_price gracefully
    final rawPrice = json['predicted_price'];
    final double price;
    if (rawPrice == null) {
      price = 0.0;
    } else if (rawPrice is num) {
      price = rawPrice.toDouble();
    } else {
      price = double.tryParse(rawPrice.toString()) ?? 0.0;
    }

    return PricePredictionResponseModel(
      predictedPrice: price,
      message: json['message'] as String? ?? '',
    );
  }

  /// Converts to JSON map
  Map<String, dynamic> toJson() {
    return {'predicted_price': predictedPrice, 'message': message};
  }
}
