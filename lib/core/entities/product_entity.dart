import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';

class ProductEntity {
  String productId;
  String categoryId;
  String brand;
  ProductUnit unit;
  String name;

  // Relationship fields
  final List<ProductImageEntity>? images;
  final List<ProductBarcodeEntity>? barcodes;
  final ProductGroupEntity? group;

  ProductEntity({
    required this.productId,
    required this.categoryId,
    required this.brand,
    required this.unit,
    required this.name,
    this.images,
    this.barcodes,
    this.group,
  });
}
