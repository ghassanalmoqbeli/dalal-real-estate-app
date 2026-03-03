import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/repos/edit_adv_page_repo.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/delete_media_params.dart';
import 'package:dartz/dartz.dart';

class DeleteMediaUseCase extends UseCase2<RspAuth, DeleteMediaParams> {
  final EditAdvPageRepo editAdvPageRepo;

  DeleteMediaUseCase({required this.editAdvPageRepo});

  @override
  Future<Either<Failure, RspAuth>> call(
    DeleteMediaParams deleteMediaParams,
  ) async {
    return await editAdvPageRepo.deleteMedia(deleteMediaParams);
  }
}
