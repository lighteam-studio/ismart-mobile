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
    create table product_image
    (
      product_image_id TEXT not null,
      image_id         TEXT not null,
      variation_id     integer,
      constraint product_image_pk
        primary key (product_image_id),
      constraint image_fk
        foreign key (image_id, image_id) references image ("", image_id),
      constraint variation_id
        foreign key (variation_id) references product_variation
    );
    ''';
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
