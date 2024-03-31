import 'package:collection/collection.dart';
import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProductGroupDbSet implements DbSet<ProductGroupEntity, Query> {
  @override
  String get tableName => 'product_group';

  @override
  String createTable() {
    return '''
    create table $tableName
    (
      product_group_id TEXT not null,
      title            TEXT not null,
      constraint product_group_pk
        primary key (product_group_id),
      constraint product_group_name_pk
        unique (title),
      constraint valid_id
        check (length(product_group_id) == 36)
    );
    ''';
  }

  @override
  Future<ProductGroupEntity?> find(String id) async {
    var database = await IsMartDatabaseUtils.getDatabase();
    var result = await database.query(tableName, where: 'product_group_id = ?', whereArgs: [id]);
    await database.close();

    if (result.isEmpty) {
      return null;
    }

    return ProductGroupEntity.fromMap(result.first);
  }

  @override
  Future<void> insert(ProductGroupEntity entity) async {
    var database = await IsMartDatabaseUtils.getDatabase();
    await database.insert(
      tableName,
      entity.toEntityMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await database.close();
  }

  @override
  Future<void> batchInsert(List<ProductGroupEntity> values) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var batch = database.batch();
    for (var group in values) {
      batch.insert(
        tableName,
        group.toEntityMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);

    await database.close();
  }

  @override
  Future<List<ProductGroupEntity>> search([Query? query]) async {
    var search = query?.search ?? '';

    var queryString = '''
      SELECT pg.product_group_id, pg.title, pc.product_category_id, pc.name FROM product_group pg
      LEFT JOIN main.product_category pc on pg.product_group_id = pc.product_group_id
    ''';

    if (search.isNotEmpty) {
      queryString += '''
        WHERE lower(pg.title) like lower(?)
        OR lower(pc.name) like lower(?)
      ''';
    }

    // Order by
    queryString += '''
      ORDER BY pg.title, pc.name;
    ''';

    var database = await IsMartDatabaseUtils.getDatabase();

    var response = await database.rawQuery(
      queryString,
      search.isNotEmpty
          ? [
              '%$search%',
              '%$search%',
            ]
          : [],
    );

    var groupedResponse = groupBy(response, (p0) {
      return (
        id: p0['product_group_id'].toString(),
        title: p0['title'].toString(),
      );
    });

    var groups = groupedResponse.entries
        .map(
          (entry) => ProductGroupEntity(
            productGroupId: entry.key.id,
            title: entry.key.title,
            categories: entry.value
                .where((element) => element['product_category_id'] != null)
                .map((e) => ProductCategoryEntity.fromMap(e))
                .toList(),
          ),
        )
        .toList();

    await database.close();

    return groups;
  }
}
