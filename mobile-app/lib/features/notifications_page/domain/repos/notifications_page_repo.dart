import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/notifications_page/data/models/fetch_notifications_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_response.dart';
import 'package:dallal_proj/features/notifications_page/data/models/notifications_response.dart';
import 'package:dallal_proj/features/notifications_page/data/models/unread_count_response.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationsPageRepo {
  Future<Either<Failure, NotificationsResponse>> fetchNotifications(
    FetchNotificationsReqModel reqModel,
  );
  Future<Either<Failure, UnreadCountResponse>> getUnreadCount(String token);
  Future<Either<Failure, MarkAsReadResponse>> markAsRead(
    MarkAsReadReqModel reqModel,
  );
  Stream<Map<String, dynamic>> startSSEStream({
    required String token,
    int lastId,
    int timeout,
    double interval,
  });
  void stopSSEStream();
}
