import 'banner.dart';

class Data {
  List<Banner>? banners;

  Data({this.banners});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banners:
        (json['banners'] as List<dynamic>?)
            ?.map((e) => Banner.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'banners': banners?.map((e) => e.toJson()).toList(),
  };
}
