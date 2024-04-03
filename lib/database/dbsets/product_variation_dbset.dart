import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_utils.dart';

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
  Future<List<ProductVariationEntity>> search(Query query) async {
    var database = await IsMartDatabaseUtils.getDatabase();

    var queryString = '''
      SELECT
        p.product_id,
        p.name,
        p.brand,
        p.unit,
        pv.variation_id,
        pv.price,
        pv.sku,
        pv.price,
        pv.stock,
        pv.thumbnail,
        m.data,
        json_group_array(ppv.value) filter ( where ppv.value is not null ) as variation_values
        FROM product_variation pv
      LEFT JOIN product p on p.product_id = pv.product_id
      LEFT JOIN media m on m.media_id = pv.thumbnail
      LEFT JOIN product_variation_property_value ppv on ppv.variation_id = pv.variation_id

      WHERE p.name LIKE ?
        OR p.brand LIKE ?
        OR pv.sku LIKE ?
      GROUP BY pv.variation_id

      LIMIT ?
      OFFSET ?
    ''';

    var response = await database.rawQuery(queryString, [
      '%${query.search}%',
      '%${query.search}%',
      '%${query.search}%',
      query.itemsPerPage,
      query.offset,
    ]);
    var products = response.map((e) => ProductVariationEntity.fromJoinProductMap(e)).toList();

    await database.close();

    return products;
  }
}
