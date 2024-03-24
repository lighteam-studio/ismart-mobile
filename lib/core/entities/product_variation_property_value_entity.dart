class ProductVariationPropertyValueEntity {
  final String valueId;
  final String variationId;
  final String propertyId;
  final String value;

  Map<String, dynamic> toEntityMap() {
    return {
      "value_id": valueId,
      "variation_id": variationId,
      "property_id": propertyId,
      "value": value,
    };
  }

  ProductVariationPropertyValueEntity({
    required this.value,
    required this.propertyId,
    required this.valueId,
    required this.variationId,
  });
}
