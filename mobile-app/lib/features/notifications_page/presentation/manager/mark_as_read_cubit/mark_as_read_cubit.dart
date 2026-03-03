import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_response.dart';
import 'package:dallal_proj/features/notifications_page/domain/use_cases/mark_as_read_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'mark_as_read_state.dart';

class MarkAsReadCubit extends Cubit<MarkAsReadState> {
  MarkAsReadCubit(this.markAsReadUseCase) : super(MarkAsReadInitial());
  final MarkAsReadUseCase markAsReadUseCase;

  Future<void> markAsRead({
    required String token,
    required int notificationId,
  }) async {
    emit(MarkAsReadLoading());

    var result = await markAsReadUseCase.call(
      MarkAsReadReqModel(token: token, notificationId: notificationId),
    );

    result.fold((failure) => emit(MarkAsReadFailure(errMsg: failure.message)), (
      response,
    ) {
      if (isSuxes(response.status)) {
        emit(
          MarkAsReadSuccess(response: response, notificationId: notificationId),
        );
        return;
      }
      emit(MarkAsReadFailure(errMsg: response.message ?? 'فشل في التحديث'));
    });
  }

  Future<void> markAllAsRead({required String token}) async {
    emit(MarkAsReadLoading());

    var result = await markAsReadUseCase.call(
      MarkAsReadReqModel(token: token, markAll: true),
    );

    result.fold((failure) => emit(MarkAsReadFailure(errMsg: failure.message)), (
      response,
    ) {
      if (isSuxes(response.status)) {
        emit(MarkAllAsReadSuccess(response: response));
        return;
      }
      emit(MarkAsReadFailure(errMsg: response.message ?? 'فشل في التحديث'));
    });
  }
}
