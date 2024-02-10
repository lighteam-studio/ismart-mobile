import 'dart:convert';

import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';

class ProductDbSet implements DbSet<ProductEntity> {
  @override
  String get tableName => 'product';

  @override
  String createTable() {
    return '''
      create table product
      (
          category_id VARCHAR(36) not null,
          brand       VARCHAR     not null,
          unit        TEXT        not null,
          name        TEXT        not null,
          product_id  VARCHAR(36) not null,
          constraint products_pk
              primary key (product_id),
          constraint category_id
              check (length(category_id) == 36),
          constraint product_id
              check (length(product_id) == 36),
          constraint unit
              check (unit in ('un', 'kg'))
      )''';
  }

  @override
  Future<ProductEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductEntity entity) async {
    var database = await IsMartDatabaseUtils.getDatabase();
    database.insert(tableName, entity.toEntityMap());
    await database.close();
  }

  @override
  Future<void> batchInsert(List<ProductEntity> values) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> search([Query? query]) async {
    var query = '''
      SELECT json_object(
        'product_id', product.product_id,
        'name', product.name,
        'brand', product.brand,
        'category_id', product.category_id,
        'category', json_object(
          'product_category_id', pc.product_category_id,
          'product_group_id', pc.product_category_id,
          'name', pc.name
        ),
        'barcodes', json_group_array(
          json_object(
            'product_barcode_id', pb.product_barcode_id,
            'product_id', pb.product_id,
            'value', pb.value
          )
        )
      ) from product
      LEFT JOIN main.product_barcode pb on product.product_id = pb.product_id
      LEFT JOIN product_category pc on pc.product_category_id = product.category_id
      GROUP BY product.product_id
      ''';
    var database = await IsMartDatabaseUtils.getDatabase();

    var result = await database.rawQuery(query);

    var products = result
        .map((e) => jsonDecode(e[e.keys.first] as String)) //
        .map((p) => ProductEntity.fromMap(p))
        .toList();

    await database.close();

    return products;
  }
}
