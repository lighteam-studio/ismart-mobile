import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';

class ProductVariationDbSet implements DbSet<ProductVariationEntity, Query> {
  @override
  String get tableName => "product_variation";

  @override
  Future<void> batchInsert(List<ProductVariationEntity> values) {
    throw UnimplementedError();
  }

  @override
  String createTable() {
    return '''
    create table $tableName
    (
      variation_id VARCHAR(36) not null,
      price        REAL        not null,
      stock        REAL        not null,
      product_id   TEXT        not null,
      sku          TEXT        not null,
      thumbnail    BLOB,
      constraint variation_id
        primary key (variation_id),
      constraint product_variation_pk
        unique (sku),
      constraint product_fk
        foreign key (product_id) references product
    );
    ''';
  }

  @override
  Future<ProductVariationEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductVariationEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductVariationEntity>> search([Query? query]) {
    throw UnimplementedError();
  }
}
