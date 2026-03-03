class Owner {
  String? id;
  String? name;
  String? phone;
  String? isPhoneVerified;
  String? profileImage;

  Owner({
    this.id,
    this.name,
    this.phone,
    this.isPhoneVerified,
    this.profileImage,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json['id'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    isPhoneVerified: json['is_phone_verified'] as String?,
    profileImage: json['profile_image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'is_phone_verified': isPhoneVerified,
    'profile_image': profileImage,
  };
}
