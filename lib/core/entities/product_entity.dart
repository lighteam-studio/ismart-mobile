import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';

class ProductEntity {
  String productId;
  String categoryId;
  String brand;
  ProductUnit unit;
  String name;

  // Relationship fields
  List<ProductImageEntity> images;
  final List<ProductBarcodeEntity> barcodes;
  final ProductCategoryEntity? category;

  Map<String, String> toEntityMap() {
    return {
      "product_id": productId,
      "category_id": categoryId,
      "brand": brand,
      "unit": unit.name,
      "name": name,
    };
  }

  ProductEntity({
    required this.productId,
    required this.categoryId,
    required this.brand,
    required this.unit,
    required this.name,
    required this.images,
    required this.barcodes,
    this.category,
  });

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      productId: map['product_id']?.toString() ?? '',
      categoryId: map['category_id']?.toString() ?? '',
      brand: map['brand']?.toString() ?? '',
      unit: ProductUnit.values.firstWhere(
        (u) => u == map['unit'],
        orElse: () => ProductUnit.un,
      ),
      name: map['name']?.toString() ?? '',
      barcodes: map.containsKey('barcodes')
          ? List.from(map['barcodes']).map((e) => ProductBarcodeEntity.fromMap(e)).toList() //
          : [],
      category: map.containsKey('category') ? ProductCategoryEntity.fromMap(map['category']) : null,
      images: [],
    );
  }
}
