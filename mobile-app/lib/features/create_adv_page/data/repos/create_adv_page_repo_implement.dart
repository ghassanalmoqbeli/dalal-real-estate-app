import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/create_adv_page/data/data_source/create_adv_remote_data_source.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_resp_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/domain/repos/create_adv_page_repo.dart';
import 'package:dartz/dartz.dart';

class CreateAdvPageRepoImplement extends CreateAdvPageRepo {
  final CreateAdvRemoteDataSource remoteDataSource;

  CreateAdvPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, AdvertisementApiResponse>> createAdv(
    AdvertisementRequestModel crAdvReqModel,
  ) async {
    try {
      var remoteCreateAdv = await remoteDataSource.createAdv(crAdvReqModel);
      return right(remoteCreateAdv);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> createMedia(
    MediaReqModel mediaReqModel,
  ) async {
    try {
      var remoteCreateMedia = await remoteDataSource.createMedia(mediaReqModel);
      return right(remoteCreateMedia);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
