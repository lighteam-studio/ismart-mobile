import 'package:get_it/get_it.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/query/query.dart';

abstract class ProductsRepository {
  Future<ProductEntity> getProduct(String id);

  Future<List<ProductEntity>> searchProducts(Query query);

  Future<void> addProduct(ProductEntity entity);

  static getInstance() {
    return GetIt.instance.get<ProductsRepository>();
  }
}
