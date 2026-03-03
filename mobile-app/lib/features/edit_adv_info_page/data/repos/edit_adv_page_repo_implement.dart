import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_resp_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/data_sources/edit_adv_remote_data_source.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/models/edit_advertisement_request_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/repos/edit_adv_page_repo.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/delete_media_params.dart';
import 'package:dartz/dartz.dart';

class EditAdvPageRepoImplement extends EditAdvPageRepo {
  final EditAdvRemoteDataSource remoteDataSource;

  EditAdvPageRepoImplement({required this.remoteDataSource});

  @override
  Future<Either<Failure, AdvertisementApiResponse>> updateAdv(
    EditAdvertisementRequestModel editAdvReqModel,
  ) async {
    try {
      var remoteUpdateAdv = await remoteDataSource.updateAdv(editAdvReqModel);
      return right(remoteUpdateAdv);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> updateMedia(
    MediaReqModel mediaReqModel,
  ) async {
    try {
      var remoteUpdateMedia = await remoteDataSource.updateMedia(mediaReqModel);
      return right(remoteUpdateMedia);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RspAuth>> deleteMedia(
    DeleteMediaParams deleteMediaParams,
  ) async {
    try {
      var remoteDeleteMedia = await remoteDataSource.deleteMedia(
        deleteMediaParams,
      );
      return right(remoteDeleteMedia);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
