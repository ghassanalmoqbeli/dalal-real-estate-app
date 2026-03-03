import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/features/home_page/domain/entities/banners_rsp_entity.dart';
import 'package:dallal_proj/features/home_page/domain/repos/home_page_repo.dart';
import 'package:dartz/dartz.dart';

class FetchAllBannersUseCase extends UseCase<BannersRspEntity, NoParam> {
  final HomePageRepo homePageRepo;

  FetchAllBannersUseCase({required this.homePageRepo});
  @override
  Future<Either<Failure, BannersRspEntity>> call([NoParam? param]) async {
    return await homePageRepo.fetchAllBans();
  }
}
