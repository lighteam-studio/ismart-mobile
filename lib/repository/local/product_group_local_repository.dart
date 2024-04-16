import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/repository/abstractions/product_group_repository.dart';
import 'package:ismart/database/ismart_db_context.dart';

class ProductGroupLocalRepository implements ProductGroupRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<void> createGroups(List<ProductGroupEntity> groups) async {
    await _context.productGroup.batchInsert(groups);

    var categories = groups
        .where((g) => g.categories != null) //
        .expand((element) => element.categories!)
        .toList();
    await _context.productCategory.batchInsert(categories);
  }

  @override
  Future<List<ProductGroupEntity>> getGroups(Query query) async {
    return await _context.productGroup.search(query);
  }

  @override
  Future<void> upsertGroup(ProductGroupEntity group) async {
    await _context.productGroup.insert(group);
  }

  @override
  Future<ProductGroupEntity?> getGroup(String id) async {
    return await _context.productGroup.find(id);
  }
}
