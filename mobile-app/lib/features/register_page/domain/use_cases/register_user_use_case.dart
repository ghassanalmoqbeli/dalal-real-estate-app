import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/register_page/data/models/register_model.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/features/register_page/domain/repos/register_page_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterUserUseCase extends UseCase<RspAuth, RegisterModel> {
  final RegisterPageRepo registerPageRepo;

  RegisterUserUseCase(this.registerPageRepo);

  @override
  Future<Either<Failure, RspAuth>> call([RegisterModel? param]) async {
    return await registerPageRepo.registerUser(param!);
  }
}
