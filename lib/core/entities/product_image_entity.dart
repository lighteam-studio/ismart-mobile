import 'dart:typed_data';

class ProductImageEntity {
  final String productImageId;
  final Uint8List data;
  final String mimeType;
  final String productId;

  ProductImageEntity({
    required this.productImageId,
    required this.data,
    required this.mimeType,
    required this.productId,
  });

  Map<String, dynamic> toEntityMap() {
    return {
      "product_image_id": productImageId,
      "data": data,
      "mime_type": mimeType,
      "product_id": productId,
    };
  }

  factory ProductImageEntity.fromMap(Map<String, dynamic> map) {
    return ProductImageEntity(
      productImageId: map['product_image_id'],
      data: map['data'],
      mimeType: map['mime_type'],
      productId: map['product_id'],
    );
  }
}
