import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_context.dart';
import 'package:ismart/repository/abstractions/i_product_category_repository.dart';

class ProductCategoryRepository implements IProductCategoryRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<List<ProductCategoryEntity>> getCategories(Query query) async {
    return await _context.productCategory.search(query);
  }

  @override
  Future<void> upsertCategory(ProductCategoryEntity category) async {
    return await _context.productCategory.insert(category);
  }
}
