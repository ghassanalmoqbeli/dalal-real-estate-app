class NotificationModel {
  final int? id;
  final int? userId;
  final String? title;
  final String? message;
  final String? type;
  final int? isRead;
  final String? createdAt;

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
  });

  /// Helper to parse int from either int or String
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: _parseInt(json['id']),
      userId: _parseInt(json['user_id']),
      title: json['title'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      isRead: _parseInt(json['is_read']),
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'title': title,
    'message': message,
    'type': type,
    'is_read': isRead,
    'created_at': createdAt,
  };

  bool get isUnread => isRead == 0;
}
