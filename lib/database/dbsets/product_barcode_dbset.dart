import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';

class ProductBarcodeDbSet implements DbSet<ProductBarcodeEntity, Query> {
  @override
  String get tableName => 'product_barcode';

  @override
  String createTable() {
    return '''
    create table product_barcode
    (
      product_barcode_id   TEXT not null,
      value                TEXT not null,
      product_variation_id TEXT not null,
      constraint product_barcode_pk
        primary key (product_barcode_id),
      constraint product_variation_fk
        foreign key (product_variation_id) references product_variation (product_variation_id)
    );
    ''';
  }

  @override
  Future<ProductBarcodeEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductBarcodeEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<void> batchInsert(List<ProductBarcodeEntity> values) async {
    var database = await IsMartDatabaseUtils.getDatabase();
    var batch = database.batch();
    for (var barcode in values) {
      batch.insert(tableName, barcode.toEntityMap());
    }
    batch.commit(noResult: true);
    await database.close();
  }

  @override
  Future<List<ProductBarcodeEntity>> search([Query? query]) {
    throw UnimplementedError();
  }
}
