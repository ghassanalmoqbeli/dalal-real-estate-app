import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';

abstract class MyAccountRemoteDataSource {
  Future<RspAuth> deleteAdv(DeleteAdvReqModel deleteAdvReqModel);
}

class MyAccountRemoteDataSourceImplement extends MyAccountRemoteDataSource {
  final Api api;

  MyAccountRemoteDataSourceImplement({required this.api});
  @override
  Future<RspAuth> deleteAdv(DeleteAdvReqModel deleteAdvReqModel) async {
    try {
      var data = await api.delete(
        url: 'ad/delete_ad.php?id=${deleteAdvReqModel.adID}',
        token: deleteAdvReqModel.token,
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
