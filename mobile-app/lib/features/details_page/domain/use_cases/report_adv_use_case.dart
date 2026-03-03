import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/details_page/data/models/report_req_model.dart';
import 'package:dallal_proj/features/details_page/domain/repos/details_page_repo.dart';
import 'package:dartz/dartz.dart';

class ReportAdvUseCase extends UseCase2<RspAuth, ReportReqModel> {
  final DetailsPageRepo detailsPageRepo;

  ReportAdvUseCase({required this.detailsPageRepo});
  @override
  Future<Either<Failure, RspAuth>> call(ReportReqModel reportReqModel) async {
    return await detailsPageRepo.reportAdv(reportReqModel);
  }
}
