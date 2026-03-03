import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_model/filter_model.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class SectionPageRepo {
  Future<Either<Failure, FilterModel>> fetchAptsList(String? token);
  Future<Either<Failure, FilterModel>> fetchHousesList(String? token);
  Future<Either<Failure, FilterModel>> fetchShopsList(String? token);
  Future<Either<Failure, FilterModel>> fetchLandsList(String? token);
  Future<Either<Failure, FilterModel>> fetchFilteredResult(
    FilterReqModel filterReqModel,
  );
}
