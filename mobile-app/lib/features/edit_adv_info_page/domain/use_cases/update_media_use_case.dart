import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/media_req_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/repos/edit_adv_page_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateMediaUseCase extends UseCase2<RspAuth, MediaReqModel> {
  final EditAdvPageRepo editAdvPageRepo;

  UpdateMediaUseCase({required this.editAdvPageRepo});
  @override
  Future<Either<Failure, RspAuth>> call(MediaReqModel crAdvReqModel) async {
    return await editAdvPageRepo.updateMedia(crAdvReqModel);
  }
}
