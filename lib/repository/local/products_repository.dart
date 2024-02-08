import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/query/product_query.dart';
import 'package:ismart/repository/abstractions/i_products_repository.dart';

class ProductsRepository implements IProductsRepository {
  @override
  Future<ProductEntity> find(String id) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<void> insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> search(ProductQuery query) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
