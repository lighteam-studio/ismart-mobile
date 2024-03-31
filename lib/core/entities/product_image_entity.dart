class ProductImageEntity {
  String productImageId;
  String imageId;
  String variationId;

  ProductImageEntity({
    required this.productImageId,
    required this.imageId,
    required this.variationId,
  });

  Map<String, dynamic> toEntityMap() {
    return {
      "product_image_id": productImageId,
      "image_id": imageId,
      "variation_id": variationId,
    };
  }

  factory ProductImageEntity.fromMap(Map<String, dynamic> map) {
    return ProductImageEntity(
      productImageId: map['product_image_id'],
      imageId: map['image_id'],
      variationId: map['variation_id'],
    );
  }
}
