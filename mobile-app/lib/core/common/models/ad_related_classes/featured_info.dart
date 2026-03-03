class FeaturedInfo {
  String? featuredId;
  String? startDate;
  String? endDate;
  num? remainingDays;

  FeaturedInfo({
    this.featuredId,
    this.startDate,
    this.endDate,
    this.remainingDays,
  });

  factory FeaturedInfo.fromJson(Map<String, dynamic> json) => FeaturedInfo(
    featuredId: json['featured_id'] as String?,
    startDate: json['start_date'] as String?,
    endDate: json['end_date'] as String?,
    remainingDays: json['remaining_days'] as num?,
  );

  Map<String, dynamic> toJson() => {
    'featured_id': featuredId,
    'start_date': startDate,
    'end_date': endDate,
    'remaining_days': remainingDays,
  };
}
