import 'package:ismart/core/query/query.dart';

class ProductImageQuery extends Query {
  String productId;

  ProductImageQuery({
    required this.productId,
    super.itemsPerPage,
    super.page,
    super.search,
  });
}
