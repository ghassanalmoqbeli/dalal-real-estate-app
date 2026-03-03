import 'package:dallal_proj/core/utils/rsp_auth.dart';

class UserProfileModel extends RspAuth {
  final String? respStatus, respMsg;
  final String? id;
  final String? name;
  final String? whatsapp;
  final String? profileImage;

  UserProfileModel({
    this.respStatus,
    this.respMsg,
    this.id,
    this.name,
    this.whatsapp,
    this.profileImage,
  }) : super(status: respStatus, message: respMsg);

  /// Factory for parsing response JSON
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      respStatus: json['status'] as String?,
      respMsg: json['message'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      whatsapp: json['whatsapp'] as String?,
      profileImage: json['profile_image'] as String?,
    );
  }

  /// Convert to JSON for request body
  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      //'name': name,
      //'whatsapp': whatsapp,
      'profile_image': 'data:image/jpg;base64,$profileImage',
    };
  }
}
