import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verification_page/Domain/repos/verification_page_repo.dart';
import 'package:dartz/dartz.dart';

class SendOtpCodeUseCase extends UseCase<RspAuth, String> {
  final VerificationPageRepo verificationPageRepo;

  SendOtpCodeUseCase(this.verificationPageRepo);

  @override
  Future<Either<Failure, RspAuth>> call([String? param]) async {
    return await verificationPageRepo.resendOTPcode(param!);
  }
}
