import 'package:dallal_proj/core/errors/error_handler.dart';
import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/features/notifications_page/data/data_source/notifications_remote_data_source.dart';
import 'package:dallal_proj/features/notifications_page/data/models/fetch_notifications_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_response.dart';
import 'package:dallal_proj/features/notifications_page/data/models/notifications_response.dart';
import 'package:dallal_proj/features/notifications_page/data/models/unread_count_response.dart';
import 'package:dallal_proj/features/notifications_page/domain/repos/notifications_page_repo.dart';
import 'package:dartz/dartz.dart';

class NotificationsPageRepoImplement extends NotificationsPageRepo {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsPageRepoImplement({required this.remoteDataSource});

  @override
  Future<Either<Failure, NotificationsResponse>> fetchNotifications(
    FetchNotificationsReqModel reqModel,
  ) async {
    try {
      var response = await remoteDataSource.fetchNotifications(reqModel);
      return right(response);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, UnreadCountResponse>> getUnreadCount(
    String token,
  ) async {
    try {
      var response = await remoteDataSource.getUnreadCount(token);
      return right(response);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, MarkAsReadResponse>> markAsRead(
    MarkAsReadReqModel reqModel,
  ) async {
    try {
      var response = await remoteDataSource.markAsRead(reqModel);
      return right(response);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Stream<Map<String, dynamic>> startSSEStream({
    required String token,
    int lastId = 0,
    int timeout = 25,
    double interval = 1.0,
  }) {
    return remoteDataSource.startSSEStream(
      token: token,
      lastId: lastId,
      timeout: timeout,
      interval: interval,
    );
  }

  @override
  void stopSSEStream() {
    remoteDataSource.stopSSEStream();
  }
}
