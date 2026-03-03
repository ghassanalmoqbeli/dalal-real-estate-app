class MeData {
  String? id;
  String? name;
  String? phone;
  String? whatsapp;
  String? isPhoneVerified;
  String? dateOfBirth;
  String? profileImage;
  String? status;
  String? createdAt;
  String? updatedAt;

  MeData({
    this.id,
    this.name,
    this.phone,
    this.whatsapp,
    this.isPhoneVerified,
    this.dateOfBirth,
    this.profileImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory MeData.fromJson(Map<String, dynamic> json) => MeData(
    id: json['id'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    whatsapp: json['whatsapp'] as String?,
    isPhoneVerified: json['is_phone_verified'] as String?,
    dateOfBirth: json['date_of_birth'] as String?,
    profileImage: json['profile_image'] as String?,
    status: json['status'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'whatsapp': whatsapp,
    'is_phone_verified': isPhoneVerified,
    'date_of_birth': dateOfBirth,
    'profile_image': profileImage,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
