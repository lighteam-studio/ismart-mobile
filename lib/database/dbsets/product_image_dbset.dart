import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/product_image_query.dart';
import 'package:ismart/database/ismart_db_utils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProductImageDbSet implements DbSet<ProductImageEntity, ProductImageQuery> {
  @override
  String get tableName => 'product_image';

  @override
  String createTable() {
    return '''
    create table $tableName
    (
      product_image_id       VARCHAR(36) not null,
      data       BLOB        not null,
      mime_type  TEXT        not null,
      product_id VARCHAR(36),
      constraint id
        primary key (product_image_id),
      constraint product_id_fk
        foreign key (product_id) references product
    )''';
  }

  @override
  Future<ProductImageEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductImageEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<void> batchInsert(List<ProductImageEntity> values) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var batch = database.batch();
    for (var image in values) {
      batch.insert(
        tableName,
        image.toEntityMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);

    await database.close();
  }

  @override
  Future<List<ProductImageEntity>> search([ProductImageQuery? query]) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var result = await database.query(
      tableName,
      where: "product_id = ?",
      whereArgs: [query?.productId],
    );

    return result.map((e) => ProductImageEntity.fromMap(e)).toList();
  }
}
