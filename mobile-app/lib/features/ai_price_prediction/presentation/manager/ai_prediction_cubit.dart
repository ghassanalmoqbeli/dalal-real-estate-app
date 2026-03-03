import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_request_entity.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/entities/price_prediction_response_entity.dart';
import 'package:dallal_proj/features/ai_price_prediction/domain/repos/ai_prediction_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ai_prediction_state.dart';

/// Cubit for managing AI price prediction state
class AiPredictionCubit extends Cubit<AiPredictionState> {
  final AiPredictionRepo repo;

  // Store last request parameters for retry functionality
  String? _lastCity;
  String? _lastAreaName;
  String? _lastPropertyType;
  String? _lastDealType;
  int? _lastAreaM2;
  int? _lastRooms;
  int? _lastBaths;
  int? _lastFloors;
  String? _lastCurrency;

  AiPredictionCubit({required this.repo}) : super(AiPredictionInitial());

  /// Predict property price using the AI model
  ///
  /// Parameters:
  /// - [city]: City name in English (e.g., "Sanaa", "Taiz", "Aden")
  /// - [areaName]: Neighborhood/area name (can be in Arabic)
  /// - [propertyType]: Type of property ("apartment", "house", "land", "shop")
  /// - [dealType]: Type of deal ("rent", "sale_freehold", "sale_waqf")
  /// - [areaM2]: Area in square meters
  /// - [rooms]: Number of rooms
  /// - [baths]: Number of bathrooms
  /// - [floors]: Number of floors
  /// - [currency]: Currency to display price in ("YER", "USD", "SAR")
  Future<void> predictPrice({
    required String city,
    required String areaName,
    required String propertyType,
    required String dealType,
    required int areaM2,
    required int rooms,
    required int baths,
    required int floors,
    required String currency,
  }) async {
    // Store parameters for retry
    _lastCity = city;
    _lastAreaName = areaName;
    _lastPropertyType = propertyType;
    _lastDealType = dealType;
    _lastAreaM2 = areaM2;
    _lastRooms = rooms;
    _lastBaths = baths;
    _lastFloors = floors;
    _lastCurrency = currency;

    emit(AiPredictionLoading());

    final request = PricePredictionRequestEntity(
      city: city,
      areaName: areaName,
      propertyType: propertyType,
      dealType: dealType,
      areaM2: areaM2,
      rooms: rooms,
      baths: baths,
      floors: floors,
    );

    final result = await repo.predictPrice(request);

    result.fold(
      (failure) => emit(AiPredictionFailure(errorMessage: failure.message)),
      (response) {
        if (response.predictedPrice == 0.0) {
          emit(
            AiPredictionFailure(
              errorMessage:
                  'المنطقة التي قمت بإدخالها غير مدعومة حالياً أو مايزال النموذج الخاص بها قيد الدراسة و التطوير',
            ),
          );
          return;
        }
        emit(AiPredictionSuccess(response: response, currency: currency));
      },
    );
  }

  /// Retry the last prediction request
  Future<void> retry() async {
    if (_lastCity != null &&
        _lastAreaName != null &&
        _lastPropertyType != null &&
        _lastDealType != null &&
        _lastAreaM2 != null &&
        _lastRooms != null &&
        _lastBaths != null &&
        _lastFloors != null &&
        _lastCurrency != null) {
      await predictPrice(
        city: _lastCity!,
        areaName: _lastAreaName!,
        propertyType: _lastPropertyType!,
        dealType: _lastDealType!,
        areaM2: _lastAreaM2!,
        rooms: _lastRooms!,
        baths: _lastBaths!,
        floors: _lastFloors!,
        currency: _lastCurrency!,
      );
    }
  }

  /// Test connection to the AI server
  Future<void> testConnection() async {
    emit(AiConnectionTesting());

    final isConnected = await repo.testConnection();

    emit(
      AiConnectionResult(
        isConnected: isConnected,
        message:
            isConnected
                ? 'تم الاتصال بخادم الذكاء الاصطناعي بنجاح ✓'
                : 'فشل الاتصال بخادم الذكاء الاصطناعي. تأكد من تشغيل السيرفر',
      ),
    );
  }

  /// Reset to initial state
  void reset() {
    emit(AiPredictionInitial());
  }
}
