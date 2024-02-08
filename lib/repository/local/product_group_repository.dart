import 'dart:convert';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/repository/is_mart_db_context.dart';
import 'package:sqflite/sqflite.dart';

class ProductGroupRepository implements IProductGroupRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<void> batchInsert(List<ProductGroupEntity> groups) async {
    var database = await _context.getDatabase();

    var batch = database.batch();
    for (var group in groups) {
      batch.insert(
        _context.productGroup,
        group.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (var category in group.categories) {
        batch.insert(
          _context.productCategory,
          category.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    await batch.commit(noResult: true);

    await database.close();
  }

  @override
  Future<List<ProductGroupEntity>> select() async {
    var database = await _context.getDatabase();

    var response = await database.rawQuery('''
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
          product_group.product_group_id
    ''');

    var results = response
        .map((e) => jsonDecode(e[e.keys.first] as String)) //
        .map((t) => ProductGroupEntity.fromMap(t))
        .toList();

    await database.close();

    return results;
  }
}
