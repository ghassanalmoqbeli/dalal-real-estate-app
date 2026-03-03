import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/login_page/data/models/set_profile_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class SetProfileRepo {
  Future<Either<Failure, UserProfileModel>> setProfile(
    UserProfileModel profileModel,
  );
}
