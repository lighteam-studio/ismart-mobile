import 'dart:typed_data';

import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/entities/product_variation_property_value_entity.dart';

class ProductVariationEntity {
  final String variationId;
  final double price;
  final double stock;
  final String productId;
  final String sku;
  final Uint8List? thumbnail;

  List<ProductVariationPropertyValueEntity>? values;
  List<ProductImageEntity>? images;
  List<ProductBarcodeEntity>? barcodes;

  Map<String, dynamic> toEntityMap() {
    return {
      "variation_id": variationId,
      "price": price,
      "stock": stock,
      "product_id": productId,
      "sku": sku,
      "thumbnail": thumbnail,
    };
  }

  ProductVariationEntity({
    required this.variationId,
    required this.productId,
    required this.price,
    required this.stock,
    required this.sku,
    required this.thumbnail,
    this.values,
    this.images,
    this.barcodes,
  });
}
