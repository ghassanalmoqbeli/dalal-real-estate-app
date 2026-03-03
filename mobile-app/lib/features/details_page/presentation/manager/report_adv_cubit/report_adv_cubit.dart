import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/details_page/data/models/report_req_model.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/report_adv_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'report_adv_state.dart';

class ReportAdvCubit extends Cubit<ReportAdvState> {
  ReportAdvCubit(this.reportAdvUseCase) : super(ReportAdvInitial());
  final ReportAdvUseCase reportAdvUseCase;

  Future<void> reportAdv(ReportReqModel reportReqModel) async {
    emit(ReportAdvLoading());

    var result = await reportAdvUseCase(reportReqModel);
    result.fold((failure) => emit(ReportAdvFailure(errMsg: failure.message)), (
      response,
    ) {
      if (isSuxes(response.status)) {
        emit(ReportAdvSuccess(response: response));
        return;
      }
      emit(
        ReportAdvFailure(errMsg: '${response.status} : ${response.message}'),
      );
    });
  }
}
