import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/details_page/domain/repos/details_page_repo.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dartz/dartz.dart';

class UnlikeAdvDetUseCase extends UseCase2<RspAuth, InteractionReqModel> {
  final DetailsPageRepo detailsPageRepo;

  UnlikeAdvDetUseCase(this.detailsPageRepo);

  @override
  Future<Either<Failure, RspAuth>> call(InteractionReqModel interAct) async {
    return await detailsPageRepo.unlikeAdv(interAct);
  }
}
