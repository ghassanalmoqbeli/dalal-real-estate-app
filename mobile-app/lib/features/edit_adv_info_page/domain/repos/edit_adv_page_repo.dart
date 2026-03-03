import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_resp_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/models/edit_advertisement_request_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/delete_media_params.dart';
import 'package:dartz/dartz.dart';

abstract class EditAdvPageRepo {
  Future<Either<Failure, AdvertisementApiResponse>> updateAdv(
    EditAdvertisementRequestModel editAdvReqModel,
  );
  Future<Either<Failure, RspAuth>> updateMedia(MediaReqModel mediaReqModel);
  Future<Either<Failure, RspAuth>> deleteMedia(
    DeleteMediaParams deleteMediaParams,
  );
}
