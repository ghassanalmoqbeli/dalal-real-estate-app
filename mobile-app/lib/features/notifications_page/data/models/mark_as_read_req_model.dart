class MarkAsReadReqModel {
  final String token;
  final int? notificationId;
  final bool markAll;

  MarkAsReadReqModel({
    required this.token,
    this.notificationId,
    this.markAll = false,
  });

  /// Returns form-data compatible map for API PUT request
  Map<String, String> toJson() {
    if (markAll) {
      return {'all': 'true'};
    }
    return {'notification_id': notificationId.toString()};
  }
}
