import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

import 'adv_data.dart';

class MyAds {
  int? count;
  List<ShowDetailsEntity>? ads;

  MyAds({this.count, this.ads});

  factory MyAds.fromJson(Map<String, dynamic> json) => MyAds(
    count: json['count'] as int?,
    ads:
        (json['ads'] as List<dynamic>?)
            ?.map((e) => AdvData.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  // Map<String, dynamic> toJson() => {
  //   'count': count,
  //   'ads': ads?.map((e) => e.toJson()).toList(),
  // };
}
