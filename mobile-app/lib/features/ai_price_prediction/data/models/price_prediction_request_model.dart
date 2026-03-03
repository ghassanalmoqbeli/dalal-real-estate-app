import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_request_entity.dart';

/// Data model for the AI price prediction request.
///
/// This model handles JSON serialization for the API request.
/// The AI model expects the following format:
/// ```json
/// {
///   "city": "Sanaa",
///   "area_name": "التحرير",
///   "property_type": "apartment",
///   "deal_type": "rent",
///   "area_m2": 120,
///   "rooms": 3,
///   "baths": 2,
///   "floors": 1
/// }
/// ```
class PricePredictionRequestModel extends PricePredictionRequestEntity {
  const PricePredictionRequestModel({
    required super.city,
    required super.areaName,
    required super.propertyType,
    required super.dealType,
    required super.areaM2,
    required super.rooms,
    required super.baths,
    required super.floors,
  });

  /// Creates a model from entity
  factory PricePredictionRequestModel.fromEntity(
    PricePredictionRequestEntity entity,
  ) {
    return PricePredictionRequestModel(
      city: entity.city,
      areaName: entity.areaName,
      propertyType: entity.propertyType,
      dealType: entity.dealType,
      areaM2: entity.areaM2,
      rooms: entity.rooms,
      baths: entity.baths,
      floors: entity.floors,
    );
  }

  /// Converts to JSON map for API request
  /// Note: AI API only accepts "rent" or "sale" for deal_type
  /// so we convert "sale_freehold" and "sale_waqf" to "sale"
  Map<String, dynamic> toJson() {
    // Convert deal_type: AI API only accepts "rent" or "sale"
    final String aiDealType;
    if (dealType == 'sale_freehold' || dealType == 'sale_waqf') {
      aiDealType = 'sale';
    } else {
      aiDealType = dealType; // "rent" stays as is
    }

    return {
      'city': city,
      'area_name': areaName,
      'property_type': propertyType,
      'deal_type': aiDealType,
      'area_m2': areaM2,
      'rooms': rooms,
      'baths': baths,
      'floors': floors,
    };
  }

  /// Creates a model from JSON response (if needed)
  factory PricePredictionRequestModel.fromJson(Map<String, dynamic> json) {
    return PricePredictionRequestModel(
      city: json['city'] as String,
      areaName: json['area_name'] as String,
      propertyType: json['property_type'] as String,
      dealType: json['deal_type'] as String,
      areaM2: json['area_m2'] as int,
      rooms: json['rooms'] as int,
      baths: json['baths'] as int,
      floors: json['floors'] as int,
    );
  }
}
