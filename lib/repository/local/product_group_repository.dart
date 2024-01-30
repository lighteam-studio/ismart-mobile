import 'package:collection/collection.dart';
import 'package:ismart/core/entities/product_category_entity.dart';
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
      SELECT * FROM ${_context.productGroup}
      LEFT JOIN ${_context.productCategory} 
        on ${_context.productCategory}.product_group_id = ${_context.productGroup}.product_group_id
    ''');

    List<ProductGroupEntity> groups = [];

    for (var row in response) {
      var group = groups.firstWhereOrNull((element) => element.productGroupId == row['group_id']);

      // If group
      if (group != null) {
        group.categories.add(ProductCategoryEntity(
          groupId: row['product_group_id']?.toString() ?? '',
          productCategoryId: row['product_category_id']?.toString() ?? '',
          name: row['name']?.toString() ?? '',
        ));
      } else {
        var group = ProductGroupEntity(
          productGroupId: row["product_group_id"]?.toString() ?? '',
          title: row["title"]?.toString() ?? '',
          categories: [],
        );
        group.categories.add(ProductCategoryEntity.fromMap(row));
        groups.add(group);
      }
    }

    print(groups);

    await database.close();

    return [];
  }
}
