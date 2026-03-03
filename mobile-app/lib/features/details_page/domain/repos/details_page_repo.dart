import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/details_page/data/models/report_req_model.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class DetailsPageRepo {
  Future<Either<Failure, RspAuth>> reportAdv(ReportReqModel reportReqModel);
  Future<Either<Failure, RspAuth>> likeAdv(InteractionReqModel advID);
  Future<Either<Failure, RspAuth>> unlikeAdv(InteractionReqModel advID);
  Future<Either<Failure, RspAuth>> faveAdv(InteractionReqModel advID);
  Future<Either<Failure, RspAuth>> unfaveAdv(InteractionReqModel advID);
}
