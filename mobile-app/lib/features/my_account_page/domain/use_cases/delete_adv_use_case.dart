import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/features/my_account_page/domain/repos/my_account_page_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteAdvUseCase extends UseCase2<RspAuth, DeleteAdvReqModel> {
  final MyAccountPageRepo myAccountPageRepo;

  DeleteAdvUseCase({required this.myAccountPageRepo});
  @override
  Future<Either<Failure, RspAuth>> call(
    DeleteAdvReqModel deleteAdvReqModel,
  ) async {
    return await myAccountPageRepo.deleteAdv(deleteAdvReqModel);
  }
}
