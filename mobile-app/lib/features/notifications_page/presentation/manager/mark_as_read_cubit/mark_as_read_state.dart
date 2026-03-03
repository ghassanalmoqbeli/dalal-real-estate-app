part of 'mark_as_read_cubit.dart';

@immutable
sealed class MarkAsReadState {}

final class MarkAsReadInitial extends MarkAsReadState {}

final class MarkAsReadLoading extends MarkAsReadState {}

final class MarkAsReadSuccess extends MarkAsReadState {
  final MarkAsReadResponse response;
  final int notificationId;

  MarkAsReadSuccess({required this.response, required this.notificationId});
}

final class MarkAllAsReadSuccess extends MarkAsReadState {
  final MarkAsReadResponse response;

  MarkAllAsReadSuccess({required this.response});
}

final class MarkAsReadFailure extends MarkAsReadState {
  final String errMsg;

  MarkAsReadFailure({required this.errMsg});
}
