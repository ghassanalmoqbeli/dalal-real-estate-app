// import 'package:dallal_proj/core/entities/adv_card_entity.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/my_account_page/data/models/user_profile/user_profile.dart';
import 'package:dartz/dartz.dart';

abstract class MainPageRepo {
  Future<Either<Failure, UserProfile>> fetchUserProfile(String? token);
  // Future<Either<Failure, List<AdvCardEntity>>> fetchAllAdvs();
}
