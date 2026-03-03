part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsLoadingMore extends NotificationsState {
  final List<NotificationModel> notifications;
  final int unreadCount;

  NotificationsLoadingMore({
    required this.notifications,
    required this.unreadCount,
  });
}

final class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;
  final int unreadCount;
  final int totalCount;
  final bool hasNew;

  NotificationsSuccess({
    required this.notifications,
    required this.unreadCount,
    required this.totalCount,
    required this.hasNew,
  });
}

final class NotificationsFailure extends NotificationsState {
  final String errMsg;

  NotificationsFailure({required this.errMsg});
}
