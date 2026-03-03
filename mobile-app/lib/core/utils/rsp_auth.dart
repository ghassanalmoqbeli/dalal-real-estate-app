class RspAuth {
  String? status, message;
  RspAuth({this.status, this.message});

  factory RspAuth.fromJson(Map<String, dynamic> json) => RspAuth(
    status: json['status'] as String?,
    message: json['message'] as String?,
  );
}
