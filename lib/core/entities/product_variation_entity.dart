import 'dart:convert';
import 'dart:typed_data';

import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/entities/product_variation_property_value_entity.dart';

class ProductVariationEntity {
  final String variationId;
  final double price;
  final double stock;
  final String productId;
  final String sku;
  final String? thumbnail;

  ProductEntity? product;
  List<ProductVariationPropertyValueEntity>? values;
  List<ProductImageEntity>? images;
  List<ProductBarcodeEntity>? barcodes;
  Uint8List? thumbnailData;
  List<String>? variationValues;

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
    this.thumbnailData,
    this.product,
    this.variationValues,
  });

  factory ProductVariationEntity.fromJoinProductMap(Map<String, dynamic> map) {
    List<String>? values = map['variation_values'] != null
        ? List<String>.from(jsonDecode(map['variation_values'])) //
        : null;

    return ProductVariationEntity(
      variationId: map['variation_id'],
      productId: map['product_id'],
      price: map['price'],
      stock: map['stock'],
      sku: map['sku'],
      thumbnail: map['thumbnail'],
      thumbnailData: map['data'],
      product: ProductEntity.fromMap(map),
      variationValues: values,
    );
  }
}
