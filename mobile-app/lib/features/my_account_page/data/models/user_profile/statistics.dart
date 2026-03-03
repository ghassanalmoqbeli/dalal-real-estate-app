class Statistics {
  int? adsCount;
  int? likedAdsCount;
  int? favoriteAdsCount;
  int? totalLikesReceived;
  int? totalFavoritesReceived;

  Statistics({
    this.adsCount,
    this.likedAdsCount,
    this.favoriteAdsCount,
    this.totalLikesReceived,
    this.totalFavoritesReceived,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    adsCount: json['ads_count'] as int?,
    likedAdsCount: json['liked_ads_count'] as int?,
    favoriteAdsCount: json['favorite_ads_count'] as int?,
    totalLikesReceived: json['total_likes_received'] as int?,
    totalFavoritesReceived: json['total_favorites_received'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'ads_count': adsCount,
    'liked_ads_count': likedAdsCount,
    'favorite_ads_count': favoriteAdsCount,
    'total_likes_received': totalLikesReceived,
    'total_favorites_received': totalFavoritesReceived,
  };
}
