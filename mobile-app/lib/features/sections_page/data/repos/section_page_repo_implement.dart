import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/sections_page/data/data_source/sections_remote_data_source.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_model/filter_model.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';
import 'package:dallal_proj/features/sections_page/domain/repos/section_page_repo.dart';
import 'package:dartz/dartz.dart';

class SectionPageRepoImplement extends SectionPageRepo {
  final SectionsRemoteDataSource remoteDataSource;

  SectionPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, FilterModel>> fetchAptsList(String? token) async {
    try {
      var sectList = await remoteDataSource.fetchAptsList(token);
      return right(sectList);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, FilterModel>> fetchHousesList(String? token) async {
    try {
      var sectList = await remoteDataSource.fetchHousesList(token);
      return right(sectList);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, FilterModel>> fetchLandsList(String? token) async {
    try {
      var sectList = await remoteDataSource.fetchLandsList(token);
      return right(sectList);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, FilterModel>> fetchShopsList(String? token) async {
    try {
      var sectList = await remoteDataSource.fetchShopsList(token);
      return right(sectList);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, FilterModel>> fetchFilteredResult(
    FilterReqModel filterReqModel,
  ) async {
    try {
      var filteredResult = await remoteDataSource.fetchFilteredResult(
        filterReqModel,
      );
      return right(filteredResult);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
