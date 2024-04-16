import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/repository/abstractions/products_repository.dart';
import 'package:ismart/database/ismart_db_context.dart';

class ProductsLocalRepository implements ProductsRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<ProductEntity> getProduct(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> addProduct(ProductEntity entity) async {
    await _context.product.insert(entity);
  }

  @override
  Future<List<ProductEntity>> searchProducts(Query query) async {
    return await _context.product.search(query);
  }
}
