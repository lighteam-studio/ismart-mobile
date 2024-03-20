class ProductVariationPropertyValueEntity {
  final String valueId;
  final String variationId;
  final String propertyId;
  final String value;

  ProductVariationPropertyValueEntity({
    required this.value,
    required this.propertyId,
    required this.valueId,
    required this.variationId,
  });
}
