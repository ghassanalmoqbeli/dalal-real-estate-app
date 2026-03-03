import 'package:dallal_proj/features/notifications_page/data/models/notification_model.dart';

class NotificationsResponse {
  final String? status;
  final NotificationsData? data;

  NotificationsResponse({this.status, this.data});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      status: json['status'] as String?,
      data:
          json['data'] == null
              ? null
              : NotificationsData.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}

class NotificationsData {
  final List<NotificationModel>? notifications;
  final int? unreadCount;
  final int? totalCount;
  final int? lastId;
  final bool? hasNew;

  NotificationsData({
    this.notifications,
    this.unreadCount,
    this.totalCount,
    this.lastId,
    this.hasNew,
  });

  /// Helper to parse int from either int or String
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// Helper to parse bool from various formats
  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) return value.toLowerCase() == 'true' || value == '1';
    return null;
  }

  factory NotificationsData.fromJson(Map<String, dynamic> json) {
    return NotificationsData(
      notifications:
          (json['notifications'] as List<dynamic>?)
              ?.map(
                (e) => NotificationModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      unreadCount: _parseInt(json['unread_count']),
      totalCount: _parseInt(json['total_count']),
      lastId: _parseInt(json['last_id']),
      hasNew: _parseBool(json['has_new']),
    );
  }

  Map<String, dynamic> toJson() => {
    'notifications': notifications?.map((e) => e.toJson()).toList(),
    'unread_count': unreadCount,
    'total_count': totalCount,
    'last_id': lastId,
    'has_new': hasNew,
  };
}
