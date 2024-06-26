import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProductCategoryDbSet implements DbSet<ProductCategoryEntity, Query> {
  @override
  String get tableName => 'product_category';

  @override
  String createTable() {
    return '''
    create table $tableName
    (
      product_category_id TEXT not null,
      name                TEXT not null,
      product_group_id    TEXT not null,
      constraint id
        primary key (product_category_id),
      constraint product_group_id
        foreign key (product_group_id) references product_group,
      constraint valid_id
        check (length(product_category_id) == 36)
    );
    ''';
  }

  @override
  Future<ProductCategoryEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductCategoryEntity entity) async {
    var database = await IsMartDatabaseUtils.getDatabase();
    await database.insert(
      tableName,
      entity.toEntityMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await database.close();
  }

  @override
  Future<void> batchInsert(List<ProductCategoryEntity> values) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var batch = database.batch();
    for (var category in values) {
      batch.insert(
        tableName,
        category.toEntityMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);

    await database.close();
  }

  @override
  Future<List<ProductCategoryEntity>> search([Query? query]) async {
    throw UnimplementedError();
  }
}
