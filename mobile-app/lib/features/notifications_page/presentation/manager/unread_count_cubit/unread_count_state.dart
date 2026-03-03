part of 'unread_count_cubit.dart';

@immutable
sealed class UnreadCountState {}

final class UnreadCountInitial extends UnreadCountState {}

final class UnreadCountLoading extends UnreadCountState {}

final class UnreadCountSuccess extends UnreadCountState {
  final int unreadCount;
  final int lastId;

  UnreadCountSuccess({required this.unreadCount, required this.lastId});
}

final class UnreadCountFailure extends UnreadCountState {
  final String errMsg;

  UnreadCountFailure({required this.errMsg});
}
