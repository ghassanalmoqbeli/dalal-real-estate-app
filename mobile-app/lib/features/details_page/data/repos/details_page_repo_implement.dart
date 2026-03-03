import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/details_page/data/data_sources/details_remote_data_source.dart';
import 'package:dallal_proj/features/details_page/data/models/report_req_model.dart';
import 'package:dallal_proj/features/details_page/domain/repos/details_page_repo.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dartz/dartz.dart';

class DetailsPageRepoImplement extends DetailsPageRepo {
  final DetailsRemoteDataSource remoteDataSource;
  // final DetailsLocalDataSource localDataSource;

  DetailsPageRepoImplement({
    required this.remoteDataSource,
    // required this.localDataSource,
  });
  @override
  Future<Either<Failure, RspAuth>> reportAdv(ReportReqModel reportModel) async {
    try {
      var remoteReportAdv = await remoteDataSource.reportAdv(reportModel);
      return right(remoteReportAdv);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> likeAdv(InteractionReqModel interAct) async {
    try {
      var remoteLikeAdv = await remoteDataSource.likeAdv(interAct);
      return right(remoteLikeAdv);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> unlikeAdv(
    InteractionReqModel interAct,
  ) async {
    try {
      var remoteUnlikeAdv = await remoteDataSource.unlikeAdv(interAct);
      return right(remoteUnlikeAdv);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> faveAdv(InteractionReqModel interAct) async {
    try {
      var remoteFavAdv = await remoteDataSource.faveAdv(interAct);
      return right(remoteFavAdv);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> unfaveAdv(
    InteractionReqModel interAct,
  ) async {
    try {
      var remoteUnfaveAdv = await remoteDataSource.unfaveAdv(interAct);
      return right(remoteUnfaveAdv);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
