class MarkAsReadResponse {
  final String? status;
  final String? message;
  final MarkAsReadData? data;

  MarkAsReadResponse({this.status, this.message, this.data});

  factory MarkAsReadResponse.fromJson(Map<String, dynamic> json) {
    return MarkAsReadResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data:
          json['data'] == null
              ? null
              : MarkAsReadData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class MarkAsReadData {
  final int? notificationId;

  MarkAsReadData({this.notificationId});

  /// Helper to parse int from either int or String
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  factory MarkAsReadData.fromJson(Map<String, dynamic> json) {
    return MarkAsReadData(notificationId: _parseInt(json['notification_id']));
  }

  Map<String, dynamic> toJson() => {'notification_id': notificationId};
}
