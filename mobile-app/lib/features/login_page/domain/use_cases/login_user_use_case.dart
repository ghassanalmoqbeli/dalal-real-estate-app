import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/login_page/data/models/login_response_model/login_rsp_model.dart';
import 'package:dallal_proj/features/login_page/domain/repos/login_page_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUserUseCase extends UseCase2<LoginRspModel, LoginReqModel> {
  final LoginPageRepo loginPageRepo;

  LoginUserUseCase(this.loginPageRepo);
  @override
  Future<Either<Failure, LoginRspModel>> call(LoginReqModel param) async {
    return await loginPageRepo.loginUser(param);
  }
}
