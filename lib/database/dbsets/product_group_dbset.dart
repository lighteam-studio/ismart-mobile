import 'dart:convert';

import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProductGroupDbSet implements DbSet<ProductGroupEntity> {
  @override
  String createTable() {
    return '''
    create table product_group
    (
      product_group_id VARCHAR(36) not null,
      title            TEXT        not null,
      constraint product_group_pk
          primary key (product_group_id),
      constraint valid_id
          check (length(product_group_id) == 36)
    )''';
  }

  @override
  String get tableName => 'product_group';

  @override
  Future<ProductGroupEntity> find(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProductGroupEntity entity) {
    throw UnimplementedError();
  }

  @override
  Future<void> batchInsert(List<ProductGroupEntity> values) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var batch = database.batch();
    for (var group in values) {
      batch.insert(
        tableName,
        group.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);

    await database.close();
  }

  @override
  Future<List<ProductGroupEntity>> search([Query? query]) async {
    var query = '''
      SELECT
        json_object(
          'product_group_id', product_group.product_group_id,
          'title',product_group.title,
          'categories', json_group_array(
            json_object(
              'product_group_id', product_group.product_group_id,
              'name', product_category.name,
              'product_category_id', product_category.product_category_id
            )
          )
        ) result
      FROM product_group
      LEFT JOIN product_category
          on product_group.product_group_id = product_category.product_group_id
      GROUP BY
          product_group.product_group_id''';

    var database = await IsMartDatabaseUtils.getDatabase();

    var response = await database.rawQuery(query);

    var results = response
        .map((e) => jsonDecode(e[e.keys.first] as String)) //
        .map((t) => ProductGroupEntity.fromMap(t))
        .toList();

    await database.close();

    return results;
  }
}
