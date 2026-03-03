import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/home_page/data/models/fetch_advs_list_rsp_model.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dallal_proj/features/home_page/domain/entities/banners_rsp_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomePageRepo {
  Future<Either<Failure, FetchAdvsListRspModel>> fetchFeaturedAdvs(
    String? token,
  );
  Future<Either<Failure, FetchAdvsListRspModel>> fetchAllAdvs(String? token);

  Future<Either<Failure, BannersRspEntity>> fetchAllBans();
  Future<Either<Failure, RspAuth>> likeAdv(InteractionReqModel advID);
  Future<Either<Failure, RspAuth>> unlikeAdv(InteractionReqModel advID);
  Future<Either<Failure, RspAuth>> faveAdv(InteractionReqModel advID);
  Future<Either<Failure, RspAuth>> unfaveAdv(InteractionReqModel advID);
}
