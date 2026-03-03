import 'package:dallal_proj/features/my_account_page/data/models/user_profile/adv_data.dart';

import 'query.dart';

class Data {
  int? totalAds;
  Query? query;
  List<AdvData2>? ads;

  Data({this.totalAds, this.query, this.ads});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalAds: json['total_ads'] as int?,
    query:
        json['query'] == null
            ? null
            : Query.fromJson(json['query'] as Map<String, dynamic>),
    ads:
        (json['ads'] as List<dynamic>?)
            ?.map((e) => AdvData2.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'total_ads': totalAds,
    'query': query?.toJson(),
    'ads': ads?.map((e) => e.toJson()).toList(),
  };
}
