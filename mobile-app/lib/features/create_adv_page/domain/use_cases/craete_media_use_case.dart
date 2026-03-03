import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/domain/repos/create_adv_page_repo.dart';
import 'package:dartz/dartz.dart';

class CreateMediaUseCase extends UseCase2<RspAuth, MediaReqModel> {
  final CreateAdvPageRepo advPageRepo;

  CreateMediaUseCase({required this.advPageRepo});
  @override
  Future<Either<Failure, RspAuth>> call(MediaReqModel crAdvReqModel) async {
    return await advPageRepo.createMedia(crAdvReqModel);
  }
}
