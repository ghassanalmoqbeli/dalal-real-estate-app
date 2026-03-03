class DeleteAdvReqModel {
  final String adID;
  final String token;

  DeleteAdvReqModel({required this.adID, required this.token});
  Map<String, dynamic> toJson() => {'id': adID};
}
