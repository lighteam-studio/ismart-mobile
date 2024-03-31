import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/database/ismart_db_context.dart';
import 'package:ismart/repository/abstractions/i_media_repository.dart';

class MediaRepository implements IMediaRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<void> addMedias(List<MediaEntity> medias) async {
    await _context.image.batchInsert(medias);
  }

  @override
  Future<List<MediaEntity>> getMedias() async {
    return await _context.image.search();
  }
}
