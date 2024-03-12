import 'package:ismart/core/entities/product_property_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProductPropertyDbset implements DbSet<ProductPropertyEntity, Query> {
  @override
  String get tableName => "product_property";

  @override
  String createTable() {
    return '''
    create table $tableName
    (
      property_id TEXT not null,
      type        TEXT not null,
      name        TEXT not null,
      product_id  TEXT not null,
      constraint property_id_pk
        primary key (property_id),
      constraint product_fk
        foreign key (product_id) references product,
      constraint type_check
        check (type IN ('text', 'number', 'color', 'base'))
    );
    ''';
  }

  @override
  Future<void> batchInsert(List<ProductPropertyEntity> values) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var batch = database.batch();

    for (var property in values) {
      batch.insert(
        tableName,
        property.toEntityMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);

    await database.close();
  }

  @override
  Future<ProductPropertyEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductPropertyEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductPropertyEntity>> search([Query? query]) {
    throw UnimplementedError();
  }
}
