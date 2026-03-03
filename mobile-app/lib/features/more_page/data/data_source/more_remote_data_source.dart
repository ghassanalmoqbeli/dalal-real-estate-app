import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';

abstract class MoreRemoteDataSource {
  Future<RspAuth> deleteAccount();
}

class MoreRemoteDataSourceImplement extends MoreRemoteDataSource {
  final Api api;

  MoreRemoteDataSourceImplement({required this.api});
  @override
  Future<RspAuth> deleteAccount() async {
    try {
      var user = getMeData();
      var data = await api.post(
        url: 'user/request_delete_account.php',
        body: null,
        token: user!.uToken!,
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
