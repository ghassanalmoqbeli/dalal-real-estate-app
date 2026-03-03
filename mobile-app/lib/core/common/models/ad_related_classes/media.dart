import 'package:dallal_proj/core/entities/media_entity/media_entity.dart';

class Media extends MediaEntity {
  String? id;
  String? type;
  String? url;
  String? mediaType;
  String? mimeType;

  Media({this.id, this.type, this.url, this.mediaType, this.mimeType})
    : super(mediaId: id, mediaUrl: url);

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json['id'] as String?,
    type: json['type'] as String?,
    url: json['url'] as String?,
    mediaType: json['media_type'] as String?,
    mimeType: json['mime_type'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'url': url,
    'media_type': mediaType,
    'mime_type': mimeType,
  };
}
