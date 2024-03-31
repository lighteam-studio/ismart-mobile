import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MediaDbSet implements DbSet<MediaEntity, Query> {
  @override
  Future<void> batchInsert(List<MediaEntity> values) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var batch = database.batch();

    for (var media in values) {
      batch.insert(
        tableName,
        media.toEntityMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);

    await database.close();
  }

  @override
  String createTable() {
    return '''
    create table $tableName
    (
      media_id  TEXT not null,
      data      BLOB not null,
      mime_type TEXT not null,
      name      TEXT not null,
      constraint media_id
        primary key (media_id)
    );
    ''';
  }

  @override
  Future<MediaEntity?> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(MediaEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<List<MediaEntity>> search([Query? query]) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var result = await database.query(
      tableName,
    );

    return result.map((e) => MediaEntity.fromMap(e)).toList();
  }

  @override
  String get tableName => "media";
}
