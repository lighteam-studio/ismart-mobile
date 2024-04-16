import 'package:get_it/get_it.dart';
import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/query/query.dart';

abstract class ProductCategoryRepository {
  Future<List<ProductCategoryEntity>> getCategories(Query query);
  Future<void> upsertCategory(ProductCategoryEntity category);

  static getInstance() {
    return GetIt.instance.get<ProductCategoryRepository>();
  }
}
