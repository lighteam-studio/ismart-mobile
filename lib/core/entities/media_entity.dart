import 'dart:typed_data';

class MediaEntity {
  final String mediaId;
  final Uint8List data;
  final String mimeType;
  final String name;

  MediaEntity({
    required this.mediaId,
    required this.data,
    required this.mimeType,
    required this.name,
  });

  Map<String, dynamic> toEntityMap() {
    return {
      "media_id": mediaId,
      "data": data,
      "mime_type": mimeType,
      "name": name,
    };
  }

  factory MediaEntity.fromMap(Map<String, dynamic> map) {
    return MediaEntity(
      mediaId: map['media_id'],
      data: map['data'],
      mimeType: map['mime_type'],
      name: map['name'],
    );
  }
}
