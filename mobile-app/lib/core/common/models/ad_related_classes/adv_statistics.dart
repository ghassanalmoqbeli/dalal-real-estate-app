class AdvStatistics {
  num? likesCount;
  num? favoritesCount;
  num? mediaCount;

  AdvStatistics({this.likesCount, this.favoritesCount, this.mediaCount});

  factory AdvStatistics.fromJson(Map<String, dynamic> json) => AdvStatistics(
    likesCount: json['likes_count'] as num?,
    favoritesCount: json['favorites_count'] as num?,
    mediaCount: json['media_count'] as num?,
  );

  Map<String, dynamic> toJson() => {
    'likes_count': likesCount,
    'favorites_count': favoritesCount,
    'media_count': mediaCount,
  };
}
