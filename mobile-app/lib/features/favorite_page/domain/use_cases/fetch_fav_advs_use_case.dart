import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/main_page/domain/repos/main_page_repo.dart';
import 'package:dallal_proj/features/my_account_page/data/models/user_profile/user_profile.dart';
import 'package:dartz/dartz.dart';

class FetchFavAdvsUseCase extends UseCase2<UserProfile, String> {
  final MainPageRepo mainPageRepo;

  FetchFavAdvsUseCase({required this.mainPageRepo});
  @override
  Future<Either<Failure, UserProfile>> call(String token) async {
    return await mainPageRepo.fetchUserProfile(token);
  }
}
