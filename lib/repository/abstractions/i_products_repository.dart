import 'package:get_it/get_it.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/query/product_query.dart';

abstract class IProductsRepository {
  Future<ProductEntity> find(String id);
  Future<List<ProductEntity>> search(ProductQuery query);
  Future<void> insert();

  static getInstance() {
    return GetIt.instance.get<IProductsRepository>();
  }
}
