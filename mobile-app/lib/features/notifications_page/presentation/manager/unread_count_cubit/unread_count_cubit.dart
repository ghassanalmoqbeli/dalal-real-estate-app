import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/notifications_page/domain/use_cases/get_unread_count_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'unread_count_state.dart';

class UnreadCountCubit extends Cubit<UnreadCountState> {
  UnreadCountCubit(this.getUnreadCountUseCase) : super(UnreadCountInitial());
  final GetUnreadCountUseCase getUnreadCountUseCase;

  int _currentUnreadCount = 0;

  int get currentUnreadCount => _currentUnreadCount;

  Future<void> getUnreadCount(String token) async {
    // Don't emit loading to avoid UI flicker - keep current state
    var result = await getUnreadCountUseCase.call(token);

    result.fold(
      (failure) => emit(UnreadCountFailure(errMsg: failure.message)),
      (response) {
        if (isSuxes(response.status)) {
          _currentUnreadCount = response.data?.unreadCount ?? 0;
          emit(
            UnreadCountSuccess(
              unreadCount: _currentUnreadCount,
              lastId: response.data?.lastId ?? 0,
            ),
          );
          return;
        }
        emit(UnreadCountFailure(errMsg: 'فشل في جلب عدد الإشعارات'));
      },
    );
  }

  /// Update unread count locally (for UI updates without API call)
  void updateUnreadCount(int count) {
    _currentUnreadCount = count;
    emit(UnreadCountSuccess(unreadCount: count, lastId: 0));
  }

  /// Decrement unread count by 1 (when a notification is marked as read)
  void decrementUnreadCount() {
    if (_currentUnreadCount > 0) {
      _currentUnreadCount--;
      emit(UnreadCountSuccess(unreadCount: _currentUnreadCount, lastId: 0));
    }
  }
}
