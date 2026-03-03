import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/features/package_details_page/domain/use_cases/get_package_info_use_case.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'get_package_info_state.dart';

class GetPackageInfoCubit extends Cubit<GetPackageInfoState> {
  GetPackageInfoCubit(this.getPackageInfoUseCase)
    : super(GetPackageInfoInitial());
  final GetPackageInfoUseCase getPackageInfoUseCase;

  Future<void> getPackageInfo(DeleteAdvReqModel idTokenModel) async {
    emit(GetPackageInfoLoading());

    var result = await getPackageInfoUseCase.call(idTokenModel);
    result.fold(
      (failure) => emit(GetPackageInfoFailure(errMsg: failure.message)),
      (package) {
        if (isSuxes(package.status)) {
          emit(GetPackageInfoSuccess(package: package.data));
          return;
        }
        emit(
          GetPackageInfoFailure(
            errMsg:
                '${package.status} : ${package.message ?? 'فشل جلب بيانات الباقة'}',
          ),
        );
      },
    );
  }
}
