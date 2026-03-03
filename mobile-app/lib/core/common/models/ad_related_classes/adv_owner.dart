import 'package:dallal_proj/core/utils/functions/is_success.dart';

class AdvOwner {
  String id;
  String name;
  String phone;
  String? whatsapp;
  String? profileImage;
  AdvOwner({
    required this.id,
    required this.name,
    required this.phone,
    this.whatsapp,
    this.profileImage,
  });

  factory AdvOwner.fromJson(Map<String, dynamic> json) => AdvOwner(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    whatsapp:
        isntNull(json['whatsapp'])
            ? json['whatsapp'] as String
            : json['phone'] as String,
    profileImage: json['profile_image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'whatsapp': whatsapp ?? phone,
    'profile_image': profileImage,
  };
}
