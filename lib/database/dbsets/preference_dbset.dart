import 'package:ismart/core/entities/preference_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class PreferenceDbSet implements DbSet<PreferenceEntity> {
  @override
  String get tableName => 'preference';

  @override
  String createTable() {
    return '''
    create table preferences
    (
      key   TEXT not null,
      value TEXT,
      constraint preferences_pk
        primary key (key)
    );
    ''';
  }

  @override
  Future<void> insert(PreferenceEntity entity) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    // Set preferences
    await database.insert(
      tableName,
      {
        "key": entity.key,
        "value": entity.value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await database.close();
  }

  @override
  Future<PreferenceEntity> find(String id) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var value = await database.query(
      tableName,
      where: "key = ?",
      whereArgs: [id],
    );

    if (value.isEmpty) {
      return PreferenceEntity(key: id, value: "");
    }

    return PreferenceEntity(
      key: value.first['key'] as String,
      value: value.first['value'] as String,
    );
  }

  @override
  Future<void> batchInsert(List<PreferenceEntity> values) {
    throw UnimplementedError();
  }

  @override
  Future<List<PreferenceEntity>> search([Query? query]) {
    throw UnimplementedError();
  }
}
