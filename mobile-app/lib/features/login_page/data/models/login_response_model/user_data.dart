import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';

class UserData extends LoggedinUserEntity {
  String? token;
  String? userId;
  String? name;
  String? phone;
  String? whatsapp;
  String? profileImage;
  String? createdAt;

  UserData({
    this.token,
    this.userId,
    this.name,
    this.phone,
    this.whatsapp,
    this.profileImage,
    this.createdAt,
  }) : super(
         uName: name,
         uPhone: phone,
         uToken: token,
         uId: userId,
         uProfileImage: profileImage,
         uWhatsapp: whatsapp,
       );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    token: json['token'] as String?,
    userId: json['user_id'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    whatsapp: json['whatsapp'] as String?,
    profileImage:
        (json['profile_image'] is String?)
            ? (json['profile_image'] != null)
                ? ((json['profile_image'] as String).contains(
                      "/api-app/api/media/get_media.php?type=user_profiles",
                    ))
                    ? json['profile_image']
                    : "/api-app/api/media/get_media.php?type=user_profiles&file=${json['profile_image']}"
                : null
            : null,
    createdAt: json['created_at'] as String?,
  );
  String? handleUserProfile(String? userProfile) {
    if (userProfile != null) {
      if (userProfile.contains(
        "/api-app/api/media/get_media.php?type=user_profiles",
      )) {
        return userProfile;
      } else {
        return "/api-app/api/media/get_media.php?type=user_profiles&file=$userProfile";
      }
    }
    return userProfile;
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'user_id': userId,
    'name': name,
    'phone': phone,
    'whatsapp': whatsapp,
    'profile_image': profileImage,
    'created_at': createdAt,
  };
}
