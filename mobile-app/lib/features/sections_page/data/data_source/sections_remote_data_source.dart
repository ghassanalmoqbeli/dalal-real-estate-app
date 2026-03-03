import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_model/filter_model.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';

abstract class SectionsRemoteDataSource {
  Future<FilterModel> fetchAptsList(String? token);
  Future<FilterModel> fetchHousesList(String? token);
  Future<FilterModel> fetchShopsList(String? token);
  Future<FilterModel> fetchLandsList(String? token);
  Future<FilterModel> fetchFilteredResult(FilterReqModel filterReqModel);
}

class SectionsRemoteDataSourceImplement extends SectionsRemoteDataSource {
  final Api api;

  SectionsRemoteDataSourceImplement({required this.api});
  @override
  Future<FilterModel> fetchAptsList(String? token) async {
    try {
      var data = await api.get(
        url:
            "search_and_filter/search_and_filter_ads.php?property_type=apartment",
        token: token,
      );
      FilterModel response = FilterModel.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }

  @override
  Future<FilterModel> fetchHousesList(String? token) async {
    try {
      var data = await api.get(
        url: "search_and_filter/search_and_filter_ads.php?property_type=house",
        token: token,
      );
      FilterModel response = FilterModel.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }

  @override
  Future<FilterModel> fetchLandsList(String? token) async {
    try {
      var data = await api.get(
        url: "search_and_filter/search_and_filter_ads.php?property_type=land",
        token: token,
      );
      FilterModel response = FilterModel.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }

  @override
  Future<FilterModel> fetchShopsList(String? token) async {
    try {
      var data = await api.get(
        url: "search_and_filter/search_and_filter_ads.php?property_type=shop",
        token: token,
      );
      FilterModel response = FilterModel.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }

  @override
  Future<FilterModel> fetchFilteredResult(FilterReqModel filterReqModel) async {
    try {
      final params = filterReqModel.toQueryParams();
      var data = await api.get(
        url: "search_and_filter/search_and_filter_ads.php?$params",
        token: filterReqModel.token,
      );
      FilterModel response = FilterModel.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }
}
