import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

import 'adv_data.dart';

class FavoriteAds {
  int? count;
  List<ShowDetailsEntity>? ads;

  FavoriteAds({this.count, this.ads});

  factory FavoriteAds.fromJson(Map<String, dynamic> json) => FavoriteAds(
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
