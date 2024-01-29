import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/repository/is_mart_db_context.dart';

class ProductGroupRepository implements IProductGroupRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<void> batchInsert(List<ProductGroupEntity> groups) async {
    var database = await _context.getDatabase();

    var batch = database.batch();
    for (var group in groups) {
      batch.insert(_context.productGroup, group.toMap());

      if (group.categories == null) continue;

      for (var category in group.categories!) {
        batch.insert(_context.productCategory, category.toMap());
      }
    }
    await batch.commit(noResult: true);

    await database.close();
  }
}
