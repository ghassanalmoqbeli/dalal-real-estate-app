import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/login_page/data/models/set_profile_req_model.dart';
import 'package:dallal_proj/features/login_page/domain/repos/set_profile_picture_repo.dart';
import 'package:dartz/dartz.dart';

class SetProfileUseCase extends UseCase2<UserProfileModel, UserProfileModel> {
  final SetProfileRepo repo;
  SetProfileUseCase({required this.repo});
  @override
  Future<Either<Failure, UserProfileModel>> call(
    UserProfileModel profileModel,
  ) async {
    return await repo.setProfile(profileModel);
  }
}
