import 'dart:io';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/data_source/ai_api_service.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/models/price_prediction_request_model.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/models/price_prediction_response_model.dart';

/// Abstract class for the AI prediction data source
abstract class AiPredictionRemoteDataSource {
  Future<PricePredictionResponseModel> predictPrice(
    PricePredictionRequestModel request,
  );
  Future<bool> testConnection();
}

/// Implementation of the AI prediction remote data source
class AiPredictionRemoteDataSourceImpl implements AiPredictionRemoteDataSource {
  final AiApiService aiApiService;

  AiPredictionRemoteDataSourceImpl({required this.aiApiService});

  @override
  Future<PricePredictionResponseModel> predictPrice(
    PricePredictionRequestModel request,
  ) async {
    try {
      final response = await aiApiService.predictPrice(
        requestBody: request.toJson(),
      );
      return PricePredictionResponseModel.fromJson(response);
    } on SocketException catch (e) {
      throw NetworkFailure(
        'لا يمكن الاتصال بخادم الذكاء الاصطناعي. تأكد من:\n'
        '1. تشغيل السيرفر على الكمبيوتر\n'
        '2. اتصال الجهازين بنفس شبكة الواي فاي\n'
        'خطأ: ${e.message}',
      );
    } on HttpException catch (e) {
      throw ServerFailure('خطأ في خادم الذكاء الاصطناعي: ${e.message}');
    } on FormatException catch (e) {
      throw ParsingFailure('خطأ في تنسيق البيانات المستلمة: ${e.message}');
    } catch (e) {
      throw UnknownFailure('خطأ غير متوقع: $e');
    }
  }

  @override
  Future<bool> testConnection() async {
    return await aiApiService.testConnection();
  }
}
