import 'package:ismart/core/entities/product_variation_property_value_entity.dart';

class ProductVariationEntity {
  final String variationId;
  final String productId;
  final double price;
  final double stock;

  List<ProductVariationPropertyValueEntity>? values;

  Map<String, dynamic> toEntityMap() {
    return {
      "variation_id": variationId,
      "product_id": productId,
      "price": price,
      "stock": stock,
    };
  }

  ProductVariationEntity({
    required this.variationId,
    required this.productId,
    required this.price,
    required this.stock,
    this.values,
  });
}
