class ProductBarcodeEntity {
  final String productBarcodeId;
  final String productVariationId;
  String value;

  ProductBarcodeEntity({
    required this.productBarcodeId,
    required this.productVariationId,
    required this.value,
  });

  Map<String, String> toEntityMap() {
    return {
      "product_barcode_id": productBarcodeId,
      "value": value,
      "product_variation_id": productVariationId,
    };
  }

  factory ProductBarcodeEntity.fromMap(Map<String, dynamic> map) {
    return ProductBarcodeEntity(
      productBarcodeId: map['product_barcode_id'] ?? '',
      productVariationId: map['product_variation_id'] ?? '',
      value: map['value'] ?? '',
    );
  }
}
