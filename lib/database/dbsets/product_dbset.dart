import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/dbsets/product_barcode_dbset.dart';
import 'package:ismart/database/dbsets/product_image_dbset.dart';
import 'package:ismart/database/ismart_db_utils.dart';

class ProductDbSet implements DbSet<ProductEntity, Query> {
  @override
  String get tableName => 'product';

  @override
  String createTable() {
    return '''
    create table $tableName
    (
      category_id TEXT not null,
      brand       TEXT not null,
      unit        TEXT not null,
      name        TEXT not null,
      product_id  TEXT not null,
      constraint products_pk
        primary key (product_id),
      constraint category_fk
        foreign key (category_id) references product_category,
      constraint category_id
        check (length(category_id) == 36),
      constraint product_id
        check (length(product_id) == 36),
      constraint unit
        check (unit in ('un', 'kg'))
    );
      ''';
  }

  @override
  Future<ProductEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductEntity entity) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    await database.transaction((txn) async {
      await txn.insert(tableName, entity.toEntityMap());

      var batch = txn.batch();
      for (var barcode in entity.barcodes) {
        batch.insert(ProductBarcodeDbSet().tableName, barcode.toEntityMap());
      }

      for (var image in entity.images) {
        batch.insert(ProductImageDbSet().tableName, image.toEntityMap());
      }

      batch.commit(noResult: true);
    });
    await database.close();
  }

  @override
  Future<void> batchInsert(List<ProductEntity> values) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> search([Query? query]) async {
    var query = '''
      SELECT p.*, pi.data, pi.mime_type FROM product p
      LEFT JOIN product_image pi on pi.product_id = p.product_id
      ORDER BY p.name
      ''';

    var database = await IsMartDatabaseUtils.getDatabase();

    var productsResult = await database.rawQuery(query);
    print(productsResult);

    await database.close();

    return [];
  }
}
