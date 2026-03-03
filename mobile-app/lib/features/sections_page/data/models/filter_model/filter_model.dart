import 'data.dart';

class FilterModel {
  String? status;
  Data? data;

  FilterModel({this.status, this.data});

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    status: json['status'] as String?,
    data:
        json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'status': status, 'data': data?.toJson()};
}
