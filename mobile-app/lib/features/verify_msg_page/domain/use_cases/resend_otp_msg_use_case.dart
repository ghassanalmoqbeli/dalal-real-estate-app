import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/repos/verify_msg_page_repo.dart';
import 'package:dartz/dartz.dart';

class ResendOtpMsgUseCase extends UseCase<RspAuth, String> {
  final VerifyMsgPageRepo verifyMsgPageRepo;

  ResendOtpMsgUseCase(this.verifyMsgPageRepo);
  @override
  Future<Either<Failure, RspAuth>> call([String? param]) async {
    return await verifyMsgPageRepo.resendOTPmsg(param!);
  }
}
