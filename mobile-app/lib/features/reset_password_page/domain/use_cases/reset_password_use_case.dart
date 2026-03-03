import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/reset_password_page/domain/repos/reset_password_page_repo.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase extends UseCase<RspAuth, LoginReqModel> {
  final ResetPasswordPageRepo resetPasswordPageRepo;

  ResetPasswordUseCase(this.resetPasswordPageRepo);
  @override
  Future<Either<Failure, RspAuth>> call([LoginReqModel? param]) async {
    return resetPasswordPageRepo.resetPassword(param!);
  }
}
