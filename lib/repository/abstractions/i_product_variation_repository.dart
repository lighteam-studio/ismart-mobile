import 'package:get_it/get_it.dart';
import 'package:ismart/core/models/product_variation_model.dart';
import 'package:ismart/core/query/query.dart';

abstract class IProductVariationRepository {
  Future<List<ProductVariationModel>> getProductVariations(Query query);

  static getInstance() {
    return GetIt.I.get<IProductVariationRepository>();
  }
}
