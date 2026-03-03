import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/more_page/domain/repos/more_page_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteAccountUseCase extends UseCase<RspAuth, NoParam> {
  final MorePageRepo morePageRepo;

  DeleteAccountUseCase({required this.morePageRepo});
  @override
  Future<Either<Failure, RspAuth>> call([NoParam? param]) async {
    return await morePageRepo.deleteAccount();
  }
}
