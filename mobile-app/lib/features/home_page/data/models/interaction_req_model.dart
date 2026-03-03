class InteractionReqModel {
  String? advID;
  String? token;
  InteractionReqModel({this.advID, this.token});

  Map<String, dynamic> toJson() => {'ad_id': advID};
}
