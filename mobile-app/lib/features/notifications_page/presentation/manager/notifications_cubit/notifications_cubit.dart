import 'dart:async';
import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/notifications_page/data/models/fetch_notifications_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/notification_model.dart';
import 'package:dallal_proj/features/notifications_page/data/repos/notifications_page_repo_implement.dart';
import 'package:dallal_proj/features/notifications_page/domain/use_cases/fetch_notifications_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({
    required this.fetchNotificationsUseCase,
    required this.notificationsPageRepo,
  }) : super(NotificationsInitial());

  final FetchNotificationsUseCase fetchNotificationsUseCase;
  final NotificationsPageRepoImplement notificationsPageRepo;

  List<NotificationModel> _notifications = [];
  int _lastId = 0;
  int _unreadCount = 0;
  Timer? _pollTimer;
  StreamSubscription? _sseSubscription;
  bool _isSSEActive = false;

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _unreadCount;
  int get lastId => _lastId;

  /// Fetch notifications from server (initial load or pagination)
  Future<void> fetchNotifications({
    required String token,
    String? readStatus,
    int limit = 50,
    int offset = 0,
    bool loadMore = false,
  }) async {
    if (!loadMore) {
      emit(NotificationsLoading());
    } else {
      emit(
        NotificationsLoadingMore(
          notifications: _notifications,
          unreadCount: _unreadCount,
        ),
      );
    }

    var result = await fetchNotificationsUseCase.call(
      FetchNotificationsReqModel(
        token: token,
        readStatus: readStatus,
        limit: limit,
        offset: offset,
        lastId: loadMore ? _lastId : 0,
      ),
    );

    result.fold(
      (failure) => emit(NotificationsFailure(errMsg: failure.message)),
      (response) {
        if (isSuxes(response.status)) {
          final newNotifications = response.data?.notifications ?? [];

          if (loadMore) {
            _notifications.addAll(newNotifications);
          } else {
            _notifications = newNotifications;
          }

          _lastId = response.data?.lastId ?? _lastId;
          _unreadCount = response.data?.unreadCount ?? _unreadCount;

          emit(
            NotificationsSuccess(
              notifications: _notifications,
              unreadCount: _unreadCount,
              totalCount: response.data?.totalCount ?? 0,
              hasNew: response.data?.hasNew ?? false,
            ),
          );
          return;
        }
        emit(NotificationsFailure(errMsg: 'فشل في جلب الإشعارات'));
      },
    );
  }

  /// Start polling for new notifications
  void startPolling({
    required String token,
    Duration interval = const Duration(seconds: 10),
  }) {
    stopPolling();
    _pollTimer = Timer.periodic(interval, (timer) async {
      await _pollForNewNotifications(token);
    });
  }

  /// Stop polling
  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  /// Poll for new notifications using last_id
  Future<void> _pollForNewNotifications(String token) async {
    var result = await fetchNotificationsUseCase.call(
      FetchNotificationsReqModel(token: token, lastId: _lastId, limit: 50),
    );

    result.fold(
      (failure) {
        // Silent fail for polling, don't emit error state
      },
      (response) {
        if (isSuxes(response.status) && (response.data?.hasNew ?? false)) {
          final newNotifications = response.data?.notifications ?? [];
          if (newNotifications.isNotEmpty) {
            _notifications.insertAll(0, newNotifications);
            _lastId = response.data?.lastId ?? _lastId;
            _unreadCount = response.data?.unreadCount ?? _unreadCount;

            emit(
              NotificationsSuccess(
                notifications: _notifications,
                unreadCount: _unreadCount,
                totalCount: response.data?.totalCount ?? _notifications.length,
                hasNew: true,
              ),
            );
          }
        }
      },
    );
  }

  /// Start SSE stream for real-time notifications
  void startSSEStream({
    required String token,
    int timeout = 25,
    double interval = 1.0,
  }) {
    if (_isSSEActive) return;
    _isSSEActive = true;

    final stream = notificationsPageRepo.startSSEStream(
      token: token,
      lastId: _lastId,
      timeout: timeout,
      interval: interval,
    );

    _sseSubscription = stream.listen((event) {
      final eventType = event['event'];
      final data = event['data'];

      switch (eventType) {
        case 'notification':
          // Add new notification at the beginning
          final notification = NotificationModel.fromJson(data['notification']);
          _notifications.insert(0, notification);
          _lastId = data['last_id'] ?? _lastId;
          _unreadCount++;

          emit(
            NotificationsSuccess(
              notifications: _notifications,
              unreadCount: _unreadCount,
              totalCount: _notifications.length,
              hasNew: true,
            ),
          );
          break;

        case 'unread_count':
        case 'ping':
          // Update unread count
          _unreadCount = data['unread_count'] ?? _unreadCount;
          _lastId = data['last_id'] ?? _lastId;

          if (state is NotificationsSuccess) {
            emit(
              NotificationsSuccess(
                notifications: _notifications,
                unreadCount: _unreadCount,
                totalCount: _notifications.length,
                hasNew: false,
              ),
            );
          }
          break;

        case 'error':
          // Handle SSE error - may want to reconnect
          break;

        case 'close':
          // Connection closed, try to reconnect after delay
          _isSSEActive = false;
          Future.delayed(const Duration(seconds: 2), () {
            if (!_isSSEActive) {
              startSSEStream(
                token: token,
                timeout: timeout,
                interval: interval,
              );
            }
          });
          break;
      }
    });
  }

  /// Stop SSE stream
  void stopSSEStream() {
    _isSSEActive = false;
    _sseSubscription?.cancel();
    _sseSubscription = null;
    notificationsPageRepo.stopSSEStream();
  }

  /// Update notification read status locally
  void markNotificationAsReadLocally(int notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1 && _notifications[index].isUnread) {
      _notifications[index] = NotificationModel(
        id: _notifications[index].id,
        userId: _notifications[index].userId,
        title: _notifications[index].title,
        message: _notifications[index].message,
        type: _notifications[index].type,
        isRead: 1,
        createdAt: _notifications[index].createdAt,
      );
      _unreadCount = (_unreadCount - 1).clamp(0, _unreadCount);

      emit(
        NotificationsSuccess(
          notifications: _notifications,
          unreadCount: _unreadCount,
          totalCount: _notifications.length,
          hasNew: false,
        ),
      );
    }
  }

  /// Mark all notifications as read locally
  void markAllAsReadLocally() {
    _notifications =
        _notifications.map((n) {
          return NotificationModel(
            id: n.id,
            userId: n.userId,
            title: n.title,
            message: n.message,
            type: n.type,
            isRead: 1,
            createdAt: n.createdAt,
          );
        }).toList();
    _unreadCount = 0;

    emit(
      NotificationsSuccess(
        notifications: _notifications,
        unreadCount: 0,
        totalCount: _notifications.length,
        hasNew: false,
      ),
    );
  }

  @override
  Future<void> close() {
    stopPolling();
    stopSSEStream();
    return super.close();
  }
}
