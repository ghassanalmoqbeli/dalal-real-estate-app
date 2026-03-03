import 'data.dart';

class UserProfile {
  String? status;
  Data? data;

  UserProfile({this.status, this.data});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    status: json['status'] as String?,
    data:
        json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}
