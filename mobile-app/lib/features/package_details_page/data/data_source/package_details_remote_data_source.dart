import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_response_model.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';

abstract class PackageDetailsRemoteDataSource {
  Future<PackageActivationResponse> getPackageInfo(
    DeleteAdvReqModel idTokenModel,
  );
}

class PackageDetailsRemoteDataSourceImplement
    extends PackageDetailsRemoteDataSource {
  final Api api;

  PackageDetailsRemoteDataSourceImplement({required this.api});
  @override
  Future<PackageActivationResponse> getPackageInfo(
    DeleteAdvReqModel idTokenModel,
  ) async {
    try {
      var data = await api.get(
        url: 'package/check_package_expiry.php?ad_id=${idTokenModel.adID}',
        token: idTokenModel.token,
      );
      PackageActivationResponse response = PackageActivationResponse.fromJson(
        data,
      );
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }
}
