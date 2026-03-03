import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/register_page/data/data_resources/register_remote_data_source.dart';
import 'package:dallal_proj/features/register_page/data/models/register_model.dart';
import 'package:dallal_proj/features/register_page/domain/repos/register_page_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterPageRepoImplement extends RegisterPageRepo {
  final RegisterRemoteDataSource remoteDataSource;

  RegisterPageRepoImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, RspAuth>> registerUser(RegisterModel regUser) async {
    try {
      var createAccount = await remoteDataSource.registerUser(regUser);
      return right(createAccount);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }

    // catch (e, stackTrace) {
    //   return left(ErrorHandler.handleError(e)); //Failure());
    //   // return left(Failure());
    // }
  }
}
