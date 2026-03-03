import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

import 'adv_data.dart';

class LikedAds {
  int? count;
  List<ShowDetailsEntity>? ads;

  LikedAds({this.count, this.ads});

  factory LikedAds.fromJson(Map<String, dynamic> json) => LikedAds(
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
