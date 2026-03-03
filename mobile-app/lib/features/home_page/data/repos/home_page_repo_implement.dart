import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/home_page/data/data_sources/home_local_data_source.dart';
import 'package:dallal_proj/features/home_page/data/data_sources/home_remote_data_source.dart';
import 'package:dallal_proj/features/home_page/data/models/fetch_advs_list_rsp_model.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dallal_proj/features/home_page/domain/entities/banners_rsp_entity.dart';
import 'package:dallal_proj/features/home_page/domain/repos/home_page_repo.dart';
import 'package:dartz/dartz.dart';

class HomePageRepoImplement extends HomePageRepo {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomePageRepoImplement({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, FetchAdvsListRspModel>> fetchAllAdvs(
    String? token,
  ) async {
    try {
      // var localAllAdvsList = localDataSource.fetchAllAdvs();
      // if (localAllAdvsList.isNotEmpty) {
      //   return right(
      //     FetchAdvsListRspModel(
      //       advList: localAllAdvsList,
      //       fetchStatus: 'local',
      //       fetchMessage: 'it is local',
      //     ),
      //   );
      // }
      var remoteAllAdvsList = await remoteDataSource.fetchAllAdvs(token);
      return right(remoteAllAdvsList);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, FetchAdvsListRspModel>> fetchFeaturedAdvs(
    String? token,
  ) async {
    try {
      // var localFeaturedAdvsList = localDataSource.fetchFeaturedAdvs();
      // if (localFeaturedAdvsList.isNotEmpty) {
      //   return right(
      //     FetchAdvsListRspModel(
      //       advList: localFeaturedAdvsList,
      //       fetchStatus: 'local',
      //       fetchMessage: 'it is local',
      //     ),
      //   );
      // }
      var remoteFeaturedAdvsList = await remoteDataSource.fetchFeaturedAdvs(
        token,
      );
      return right(remoteFeaturedAdvsList);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, BannersRspEntity>> fetchAllBans() async {
    try {
      var remoteBanners = await remoteDataSource.fetchAllBans();
      return right(remoteBanners);
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
