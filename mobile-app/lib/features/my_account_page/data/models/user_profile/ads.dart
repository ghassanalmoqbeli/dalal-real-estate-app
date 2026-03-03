import 'package:dallal_proj/core/utils/functions/get_only_active_advs.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

import 'favorite_ads.dart';
import 'liked_ads.dart';
import 'my_ads.dart';

class Ads {
  MyAds? myAds;
  LikedAds? likedAds;
  FavoriteAds? favoriteAds;

  Ads({this.myAds, this.likedAds, this.favoriteAds});

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
    myAds:
        json['my_ads'] == null
            ? null
            : MyAds.fromJson(json['my_ads'] as Map<String, dynamic>),
    likedAds:
        json['liked_ads'] == null
            ? null
            : LikedAds.fromJson(json['liked_ads'] as Map<String, dynamic>),
    favoriteAds:
        json['favorite_ads'] == null
            ? null
            : FavoriteAds.fromJson(
              json['favorite_ads'] as Map<String, dynamic>,
            ),
  );

  Map<int, List<ShowDetailsEntity>> toMyAccMap() => {
    0: myAds?.ads ?? <ShowDetailsEntity>[],
    1: getOnlyActiveAds(likedAds?.ads ?? <ShowDetailsEntity>[]),
    2: getOnlyActiveAds(favoriteAds?.ads ?? <ShowDetailsEntity>[]),
  };
}
