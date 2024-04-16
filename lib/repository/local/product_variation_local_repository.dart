import 'package:ismart/core/models/product_variation_model.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/ismart_db_context.dart';
import 'package:ismart/repository/abstractions/product_variation_repository.dart';

class ProductVariationLocalRepository implements ProductVariationRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<List<ProductVariationModel>> getProductVariations(Query query) async {
    var response = await _context.productVariation.search(query);
    return response.map((e) => ProductVariationModel.fromEntity(e)).toList();
  }
}
