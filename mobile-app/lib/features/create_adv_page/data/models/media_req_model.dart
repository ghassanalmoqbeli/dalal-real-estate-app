class MediaReqModel {
  String token;
  String adId;
  String media64;

  MediaReqModel({
    required this.adId,
    required this.media64,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
    'ad_id': adId,
    'media_base64': 'data:image/;base64,$media64',
    'type': 'image',
  };
}
