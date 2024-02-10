class ProductBarcodeEntity {
  final String productBarcodeId;
  final String productId;
  String value;

  ProductBarcodeEntity({
    required this.productBarcodeId,
    required this.productId,
    required this.value,
  });

  Map<String, String> toEntityMap() {
    return {
      "product_barcode_id": productBarcodeId,
      "product_id": productId,
      "value": value,
    };
  }

  factory ProductBarcodeEntity.fromMap(Map<String, dynamic> map) {
    return ProductBarcodeEntity(
      productBarcodeId: map['product_barcode_id']?.toString() ?? '',
      productId: map['product_id']?.toString() ?? '',
      value: map['value']?.toString() ?? '',
    );
  }
}
