class NotificationEntity {
  final int? id;
  final int? userId;
  final String? title;
  final String? message;
  final String? type;
  final bool isRead;
  final DateTime? createdAt;

  NotificationEntity({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.type,
    this.isRead = false,
    this.createdAt,
  });

  NotificationEntity copyWith({
    int? id,
    int? userId,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
