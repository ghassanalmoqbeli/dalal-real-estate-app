import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_model/filter_model.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';
import 'package:dallal_proj/features/sections_page/domain/repos/section_page_repo.dart';
import 'package:dartz/dartz.dart';

class FetchFilteredResultUseCase extends UseCase2<FilterModel, FilterReqModel> {
  final SectionPageRepo sectionPageRepo;

  FetchFilteredResultUseCase(this.sectionPageRepo);

  @override
  Future<Either<Failure, FilterModel>> call(
    FilterReqModel filterReqModel,
  ) async {
    return await sectionPageRepo.fetchFilteredResult(filterReqModel);
  }
}
