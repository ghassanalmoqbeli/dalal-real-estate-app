import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/login_page/data/data_resources/set_profile_remote_data_source.dart';
import 'package:dallal_proj/features/login_page/data/models/set_profile_req_model.dart';
import 'package:dallal_proj/features/login_page/domain/repos/set_profile_picture_repo.dart';
import 'package:dartz/dartz.dart';

class SetProfileRepoImplement extends SetProfileRepo {
  final SetProfileRemoteDataSource remoteDataSource;
  SetProfileRepoImplement({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserProfileModel>> setProfile(
    UserProfileModel profileModel,
  ) async {
    try {
      final result = await remoteDataSource.setProfile(profileModel);
      return Right(result);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
