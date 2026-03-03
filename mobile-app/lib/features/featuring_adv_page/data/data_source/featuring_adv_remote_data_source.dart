import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_model.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_response_model.dart';

abstract class FeaturingAdvRemoteDataSource {
  Future<PackageActivationResponse> featureTheAdv(FeatureAdvModel featureAdv);
}

class FeaturingAdvRemoteDataSourceImplement
    extends FeaturingAdvRemoteDataSource {
  final Api api;

  FeaturingAdvRemoteDataSourceImplement({required this.api});
  @override
  Future<PackageActivationResponse> featureTheAdv(
    FeatureAdvModel featureAdv,
  ) async {
    try {
      var data = await api.post(
        url: 'package/activate_package.php',
        body: featureAdv.toJson(),
        token: featureAdv.token,
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
