import 'package:ismart/core/entities/product_variation_property_value_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';

class ProductVariationPropertyValueDbSet extends DbSet<ProductVariationPropertyValueEntity, Query> {
  @override
  Future<void> batchInsert(List<ProductVariationPropertyValueEntity> values) {
    throw UnimplementedError();
  }

  @override
  String createTable() {
    return '''
    create table product_variation_property_value
    (
      value_id     VARCHAR(36) not null,
      variation_id TEXT        not null,
      property_id  VARCHAR(36),
      value        TEXT        not null,
      constraint product_variation_property_value_pk
        primary key (value_id),
      constraint property_fk
        foreign key (property_id) references product_property,
      constraint variation_fk
        foreign key (variation_id) references product_variation
    );
    ''';
  }

  @override
  Future<ProductVariationPropertyValueEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductVariationPropertyValueEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductVariationPropertyValueEntity>> search([Query? query]) {
    throw UnimplementedError();
  }

  @override
  String get tableName => "product_variation_property_value";
}
