import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/verification_page/Domain/repos/verification_page_repo.dart';
import 'package:dallal_proj/features/verification_page/data/data_resources/verification_remote_data_source.dart';
import 'package:dartz/dartz.dart';

class VerificationPageRepoImplement extends VerificationPageRepo {
  final VerificationRemoteDataSource remoteDataSource;

  VerificationPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, RspAuth>> resendOTPcode(String phoneNumber) async {
    try {
      var sendOtp = await remoteDataSource.resendMsg(phoneNumber);
      return right(sendOtp);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
