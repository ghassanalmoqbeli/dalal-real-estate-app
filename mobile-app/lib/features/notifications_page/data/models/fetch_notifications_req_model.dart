class FetchNotificationsReqModel {
  final String token;
  final String? readStatus; // "true", "false", or null for all
  final int limit;
  final int offset;
  final int lastId;

  FetchNotificationsReqModel({
    required this.token,
    this.readStatus,
    this.limit = 50,
    this.offset = 0,
    this.lastId = 0,
  });

  String toQueryParams() {
    final params = <String, String>{
      'limit': limit.toString(),
      'offset': offset.toString(),
      'last_id': lastId.toString(),
    };
    if (readStatus != null) {
      params['read'] = readStatus!;
    }
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}
