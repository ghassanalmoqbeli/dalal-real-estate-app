import 'package:dallal_proj/features/home_page/domain/entities/banners_rsp_entity.dart';

import 'data.dart';

class BannersModel extends BannersRspEntity {
  String? status;
  Data? data;

  BannersModel({this.status, this.data})
    : super(statusBans: status, bansList: data?.banners);

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
    status: json['status'] as String?,
    data:
        json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}
