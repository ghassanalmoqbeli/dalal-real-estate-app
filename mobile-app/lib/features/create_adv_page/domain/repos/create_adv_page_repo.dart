import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_resp_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class CreateAdvPageRepo {
  Future<Either<Failure, AdvertisementApiResponse>> createAdv(
    AdvertisementRequestModel crAdvReqModel,
  );
  Future<Either<Failure, RspAuth>> createMedia(MediaReqModel mediaReqModel);
}
