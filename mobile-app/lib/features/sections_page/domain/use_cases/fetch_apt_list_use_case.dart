import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_model/filter_model.dart';
import 'package:dallal_proj/features/sections_page/domain/repos/section_page_repo.dart';
import 'package:dartz/dartz.dart';

class FetchAptsListUseCase extends UseCase<FilterModel, String> {
  final SectionPageRepo sectionPageRepo;

  FetchAptsListUseCase(this.sectionPageRepo);
  @override
  Future<Either<Failure, FilterModel>> call([String? token]) async {
    return await sectionPageRepo.fetchAptsList(token);
  }
}
