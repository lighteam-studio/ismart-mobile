import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/database/ismart_db_context.dart';

class ProductGroupRepository implements IProductGroupRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<void> createGroups(List<ProductGroupEntity> groups) async {
    await _context.productGroup.batchInsert(groups);
    var categories = groups.expand((element) => element.categories).toList();
    await _context.productCategory.batchInsert(categories);
  }

  @override
  Future<List<ProductGroupEntity>> getGroups() async {
    return await _context.productGroup.search();
  }
}
