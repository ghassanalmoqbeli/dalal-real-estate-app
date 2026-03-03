class UnreadCountResponse {
  final String? status;
  final UnreadCountData? data;

  UnreadCountResponse({this.status, this.data});

  factory UnreadCountResponse.fromJson(Map<String, dynamic> json) {
    return UnreadCountResponse(
      status: json['status'] as String?,
      data:
          json['data'] == null
              ? null
              : UnreadCountData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}

class UnreadCountData {
  final int? unreadCount;
  final int? lastId;

  UnreadCountData({this.unreadCount, this.lastId});

  /// Helper to parse int from either int or String
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  factory UnreadCountData.fromJson(Map<String, dynamic> json) {
    return UnreadCountData(
      unreadCount: _parseInt(json['unread_count']),
      lastId: _parseInt(json['last_id']),
    );
  }

  Map<String, dynamic> toJson() => {
    'unread_count': unreadCount,
    'last_id': lastId,
  };
}
