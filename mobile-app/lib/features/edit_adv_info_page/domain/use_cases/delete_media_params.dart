class DeleteMediaParams {
  final int mediaId;
  final String token;

  DeleteMediaParams({required this.mediaId, required this.token});
  Map<String, dynamic> toJson() => {'media_id': mediaId};
}
