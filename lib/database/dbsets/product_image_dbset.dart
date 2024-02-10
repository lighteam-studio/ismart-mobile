import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';

class ProductImageDbSet implements DbSet<ProductImageEntity> {
  @override
  String createTable() {
    return '''
    create table product_image
    (
      id         VARCHAR(36) not null,
      data       BLOB        not null,
      mime_type  TEXT        not null,
      name       TEXT        not null,
      product_id VARCHAR(36),
      constraint id
        primary key (id),
      constraint product_id_fk
        foreign key (product_id) references product
    )''';
  }

  @override
  String get tableName => 'product_image';

  @override
  Future<ProductImageEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductImageEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<void> batchInsert(List<ProductImageEntity> values) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductImageEntity>> search([Query? query]) {
    throw UnimplementedError();
  }
}
