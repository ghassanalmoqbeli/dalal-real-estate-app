import 'ads.dart';
import 'statistics.dart';
import 'user.dart';

class Data {
  MeData? user;
  Statistics? statistics;
  int? featuredAdsCount;
  Ads? ads;

  Data({this.user, this.statistics, this.featuredAdsCount, this.ads});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user:
        json['user'] == null
            ? null
            : MeData.fromJson(json['user'] as Map<String, dynamic>),
    statistics:
        json['statistics'] == null
            ? null
            : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
    featuredAdsCount: json['featured_ads_count'] as int?,
    ads:
        json['ads'] == null
            ? null
            : Ads.fromJson(json['ads'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'user': user?.toJson(),
    'statistics': statistics?.toJson(),
    'featured_ads_count': featuredAdsCount,
    // 'ads': ads?.toJson(),
  };
}
