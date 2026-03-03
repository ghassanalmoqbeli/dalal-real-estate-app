import 'dart:async';
import 'dart:convert';

import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/features/notifications_page/data/models/fetch_notifications_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_response.dart';
import 'package:dallal_proj/features/notifications_page/data/models/notifications_response.dart';
import 'package:dallal_proj/features/notifications_page/data/models/unread_count_response.dart';
import 'package:http/http.dart' as http;

abstract class NotificationsRemoteDataSource {
  Future<NotificationsResponse> fetchNotifications(
    FetchNotificationsReqModel reqModel,
  );
  Future<UnreadCountResponse> getUnreadCount(String token);
  Future<MarkAsReadResponse> markAsRead(MarkAsReadReqModel reqModel);
  Stream<Map<String, dynamic>> startSSEStream({
    required String token,
    int lastId,
    int timeout,
    double interval,
  });
  void stopSSEStream();
}

class NotificationsRemoteDataSourceImplement
    extends NotificationsRemoteDataSource {
  final Api api;

  // SSE related fields
  StreamController<Map<String, dynamic>>? _eventController;
  http.Client? _sseClient;
  bool _isStreamActive = false;

  NotificationsRemoteDataSourceImplement({required this.api});

  @override
  Future<NotificationsResponse> fetchNotifications(
    FetchNotificationsReqModel reqModel,
  ) async {
    try {
      var data = await api.get(
        url: 'notification/get_notifications.php?${reqModel.toQueryParams()}',
        token: reqModel.token,
      );
      NotificationsResponse response = NotificationsResponse.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }

  @override
  Future<UnreadCountResponse> getUnreadCount(String token) async {
    try {
      var data = await api.get(
        url: 'notification/unread_count.php',
        token: token,
      );
      UnreadCountResponse response = UnreadCountResponse.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }

  @override
  Future<MarkAsReadResponse> markAsRead(MarkAsReadReqModel reqModel) async {
    try {
      var data = await api.put(
        url: 'notification/mark_as_read.php',
        body: reqModel.toJson(),
        token: reqModel.token,
      );
      MarkAsReadResponse response = MarkAsReadResponse.fromJson(data);
      return response;
    } on FormatException catch (e) {
      throw ParsingFailure("Invalid JSON: ${e.message}");
    } on Exception catch (e) {
      throw ServerFailure("Server error: ${e.toString()}");
    }
  }

  @override
  Stream<Map<String, dynamic>> startSSEStream({
    required String token,
    int lastId = 0,
    int timeout = 25,
    double interval = 1.0,
  }) {
    _eventController = StreamController<Map<String, dynamic>>.broadcast();
    _isStreamActive = true;

    final uri = Uri.parse(
      '${api.baseURL}notification/stream.php?last_id=$lastId&timeout=$timeout&interval=$interval',
    );

    _sseClient = http.Client();
    final request = http.Request('GET', uri);
    request.headers['Authorization'] = 'Bearer $token';

    _sseClient!
        .send(request)
        .then((response) {
          String? currentEvent;
          final StringBuffer currentData = StringBuffer();

          response.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .listen(
                (line) {
                  if (!_isStreamActive) return;

                  if (line.startsWith('event:')) {
                    currentEvent = line.substring(6).trim();
                  } else if (line.startsWith('data:')) {
                    currentData.clear();
                    currentData.write(line.substring(5).trim());
                  } else if (line.isEmpty && currentEvent != null) {
                    // End of event
                    try {
                      final data = json.decode(currentData.toString());
                      _eventController?.add({
                        'event': currentEvent!,
                        'data': data,
                      });
                    } catch (e) {
                      // Invalid JSON, skip
                    }
                    currentEvent = null;
                    currentData.clear();
                  } else if (currentEvent != null && currentData.isNotEmpty) {
                    // Multi-line data
                    currentData.write('\n$line');
                  }
                },
                onError: (error) {
                  _eventController?.add({
                    'event': 'error',
                    'data': {'message': error.toString()},
                  });
                },
                onDone: () {
                  if (_isStreamActive) {
                    _eventController?.add({
                      'event': 'close',
                      'data': {'message': 'Connection closed'},
                    });
                  }
                  _eventController?.close();
                },
                cancelOnError: false,
              );
        })
        .catchError((error) {
          _eventController?.addError(error);
        });

    return _eventController!.stream;
  }

  @override
  void stopSSEStream() {
    _isStreamActive = false;
    _sseClient?.close();
    _sseClient = null;
    _eventController?.close();
    _eventController = null;
  }
}
