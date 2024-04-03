import 'dart:typed_data';

import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';

class ProductVariationModel {
  final String variationId;
  final String name;
  final String brand;
  final double price;
  final double stock;
  final ProductUnit unit;
  final Uint8List? thumbnail;
  final List<String>? variationValues;

  String get nameWithVariations {
    if (variationValues != null && variationValues!.isNotEmpty) {
      return "$name (${variationValues!.join(' - ')})";
    }

    return name;
  }

  ProductVariationModel({
    required this.variationId,
    required this.name,
    required this.brand,
    required this.price,
    required this.stock,
    required this.unit,
    required this.thumbnail,
    required this.variationValues,
  });

  factory ProductVariationModel.fromEntity(ProductVariationEntity entity) {
    return ProductVariationModel(
      variationId: entity.variationId,
      name: entity.product?.name ?? '',
      brand: entity.product?.brand ?? '',
      price: entity.price,
      stock: entity.stock,
      unit: entity.product?.unit ?? ProductUnit.un,
      thumbnail: entity.thumbnailData,
      variationValues: entity.variationValues,
    );
  }
}
