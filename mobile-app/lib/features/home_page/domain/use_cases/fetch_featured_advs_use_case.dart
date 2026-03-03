import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/features/home_page/data/models/fetch_advs_list_rsp_model.dart';
import 'package:dallal_proj/features/home_page/domain/repos/home_page_repo.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedAdvsUseCase extends UseCase<FetchAdvsListRspModel, String> {
  final HomePageRepo mainPageRepo;

  FetchFeaturedAdvsUseCase(this.mainPageRepo);

  @override
  Future<Either<Failure, FetchAdvsListRspModel>> call([String? token]) async {
    return await mainPageRepo.fetchFeaturedAdvs(token);
  }
}
