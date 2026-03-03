import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/main_page/data/data_source/main_remote_data_source.dart';
import 'package:dallal_proj/features/main_page/domain/repos/main_page_repo.dart';
import 'package:dallal_proj/features/my_account_page/data/models/user_profile/user_profile.dart';
import 'package:dartz/dartz.dart';

class MainPageRepoImplement extends MainPageRepo {
  final MainRemoteDataSource remoteDataSource;

  MainPageRepoImplement({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserProfile>> fetchUserProfile(String? token) async {
    try {
      var userProfile = await remoteDataSource.getUserProfileData(token);
      return right(userProfile);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
