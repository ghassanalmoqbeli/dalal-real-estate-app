class FeatureAdvModel {
  final String adID;
  final String token;
  final String packageID;

  FeatureAdvModel({
    required this.adID,
    required this.token,
    required this.packageID,
  });
  Map<String, dynamic> toJson() => {'ad_id': adID, 'package_id': packageID};
}
