import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/functions/delete_user_login_data.dart';
import 'package:dallal_proj/core/utils/functions/is_loggedin.dart';
import 'package:dallal_proj/features/login_page/data/data_resources/login_local_data_source.dart';
import 'package:dallal_proj/features/login_page/data/data_resources/login_remote_data_source.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/login_page/data/models/login_response_model/login_rsp_model.dart';
import 'package:dallal_proj/features/login_page/domain/repos/login_page_repo.dart';
import 'package:dartz/dartz.dart';

class LoginPageRepoImplement extends LoginPageRepo {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginPageRepoImplement({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, LoginRspModel>> loginUser(
    LoginReqModel loginModel,
  ) async {
    try {
      var loggedUser = localDataSource.getLoggedinUserData();
      if (isLoggedin(loggedUser)) {
        deleteUserLoginData();
      }
      var loginUser = await remoteDataSource.loginUser(loginModel);
      return right(loginUser);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
