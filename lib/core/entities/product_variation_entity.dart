import 'package:ismart/core/entities/product_variation_property_value_entity.dart';

class ProductVariationEntity {
  final String id;
  final String productId;
  final double price;
  final double stock;

  List<ProductVariationPropertyValueEntity>? values;

  ProductVariationEntity({
    required this.id,
    required this.productId,
    required this.price,
    required this.stock,
    this.values,
  });
}
