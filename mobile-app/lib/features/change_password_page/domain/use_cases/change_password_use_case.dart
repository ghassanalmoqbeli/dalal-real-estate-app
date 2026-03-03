import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/change_password_page/data/models/change_pass_req_model.dart';
import 'package:dallal_proj/features/change_password_page/domain/repos/change_password_page_repo.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUseCase extends UseCase2<RspAuth, ChangePassReqModel> {
  final ChangePasswordPageRepo changePasswordPageRepo;

  ChangePasswordUseCase({required this.changePasswordPageRepo});
  @override
  Future<Either<Failure, RspAuth>> call(
    ChangePassReqModel changePassModel,
  ) async {
    return await changePasswordPageRepo.changePassword(changePassModel);
  }
}
