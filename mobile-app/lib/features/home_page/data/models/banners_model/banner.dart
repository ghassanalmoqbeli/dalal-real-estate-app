import 'package:dallal_proj/features/home_page/domain/entities/banner_entity.dart';

class Banner extends BannerEntity {
  String? id;
  String? adminId;
  String? imageUrl;
  String? linkUrl;
  String? sponsorName;
  String? sponsorPhone;
  String? cost;
  String? startDate;
  String? endDate;
  String? active;
  String? createdAt;
  String? updatedAt;

  Banner({
    this.id,
    this.adminId,
    this.imageUrl,
    this.linkUrl,
    this.sponsorName,
    this.sponsorPhone,
    this.cost,
    this.startDate,
    this.endDate,
    this.active,
    this.createdAt,
    this.updatedAt,
  }) : super(bannerImg: imageUrl, distBanUrl: linkUrl);

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json['id'] as String?,
    adminId: json['admin_id'] as String?,
    imageUrl: json['image_url'] as String?,
    linkUrl: json['link_url'] as String?,
    sponsorName: json['sponsor_name'] as String?,
    sponsorPhone: json['sponsor_phone'] as String?,
    cost: json['cost'] as String?,
    startDate: json['start_date'] as String?,
    endDate: json['end_date'] as String?,
    active: json['active'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'admin_id': adminId,
    'image_url': imageUrl,
    'link_url': linkUrl,
    'sponsor_name': sponsorName,
    'sponsor_phone': sponsorPhone,
    'cost': cost,
    'start_date': startDate,
    'end_date': endDate,
    'active': active,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
