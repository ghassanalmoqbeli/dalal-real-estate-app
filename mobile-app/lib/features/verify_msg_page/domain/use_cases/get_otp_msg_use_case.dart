import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/get_otp_resp_model.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/repos/verify_msg_page_repo.dart';
import 'package:dartz/dartz.dart';

class GetOtpMsgUseCase extends UseCase<GetOtpRespModel, String> {
  final VerifyMsgPageRepo verifyMsgPageRepo;

  GetOtpMsgUseCase(this.verifyMsgPageRepo);
  @override
  Future<Either<Failure, GetOtpRespModel>> call([String? param]) async {
    return await verifyMsgPageRepo.getOTPmsg(param!);
  }
}
