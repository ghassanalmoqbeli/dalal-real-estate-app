import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_resp_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';

abstract class CreateAdvRemoteDataSource {
  Future<AdvertisementApiResponse> createAdv(
    AdvertisementRequestModel crAdvReqModel,
  );
  Future<RspAuth> createMedia(MediaReqModel mediaReqModel);
}

class CreateAdvRemoteDataSourceImplement extends CreateAdvRemoteDataSource {
  final Api api;

  CreateAdvRemoteDataSourceImplement({required this.api});
  @override
  Future<AdvertisementApiResponse> createAdv(
    AdvertisementRequestModel crAdvReqModel,
  ) async {
    try {
      var data = await api.post(
        url: 'ad/create_ad.php',
        body: crAdvReqModel.toJson(),
        token: crAdvReqModel.userToken,
      );
      AdvertisementApiResponse response = AdvertisementApiResponse.fromJson(
        data,
      );
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }

  @override
  Future<RspAuth> createMedia(MediaReqModel mediaReqModel) async {
    try {
      var data = await api.post(
        url: 'ad/create_ad_media.php',
        body: mediaReqModel.toJson(),
        token: mediaReqModel.token,
      );
      RspAuth response = RspAuth.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }
}
