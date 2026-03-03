import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class MyAccountPageRepo {
  Future<Either<Failure, RspAuth>> deleteAdv(
    DeleteAdvReqModel deleteAdvReqModel,
  );
}
