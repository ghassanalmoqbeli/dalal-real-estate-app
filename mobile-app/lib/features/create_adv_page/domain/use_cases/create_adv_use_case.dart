import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_resp_model.dart';
import 'package:dallal_proj/features/create_adv_page/domain/repos/create_adv_page_repo.dart';
import 'package:dartz/dartz.dart';

class CreateAdvUseCase
    extends UseCase2<AdvertisementApiResponse, AdvertisementRequestModel> {
  final CreateAdvPageRepo advPageRepo;

  CreateAdvUseCase({required this.advPageRepo});
  @override
  Future<Either<Failure, AdvertisementApiResponse>> call(
    AdvertisementRequestModel crAdvReqModel,
  ) async {
    return await advPageRepo.createAdv(crAdvReqModel);
  }
}
