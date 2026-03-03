class ReportReqModel {
  final String adID;
  final String reason;
  final String token;
  final String? description;

  ReportReqModel({
    required this.token,
    required this.adID,
    required this.reason,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    'ad_id': adID,
    'reason': reason,
    'description': description,
  };
}
