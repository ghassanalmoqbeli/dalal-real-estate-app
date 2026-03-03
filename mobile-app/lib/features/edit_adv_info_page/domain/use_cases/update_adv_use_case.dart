import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_resp_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/models/edit_advertisement_request_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/repos/edit_adv_page_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateAdvUseCase
    extends UseCase2<AdvertisementApiResponse, EditAdvertisementRequestModel> {
  final EditAdvPageRepo editAdvPageRepo;

  UpdateAdvUseCase({required this.editAdvPageRepo});

  @override
  Future<Either<Failure, AdvertisementApiResponse>> call(
    EditAdvertisementRequestModel editAdvReqModel,
  ) async {
    return await editAdvPageRepo.updateAdv(editAdvReqModel);
  }
}
