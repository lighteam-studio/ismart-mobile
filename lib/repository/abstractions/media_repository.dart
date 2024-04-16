import 'package:get_it/get_it.dart';
import 'package:ismart/core/entities/media_entity.dart';

abstract class MediaRepository {
  Future<void> addMedias(List<MediaEntity> medias);

  Future<List<MediaEntity>> getMedias();

  static getInstance() {
    return GetIt.I.get<MediaRepository>();
  }
}
