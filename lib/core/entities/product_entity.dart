import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/entities/product_property_entity.dart';
import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';

class ProductEntity {
  String categoryId;
  String brand;
  ProductUnit unit;
  String name;
  String productId;

  // Relationship fields
  List<ProductVariationEntity>? variations;

  List<ProductPropertyEntity>? properties;
  ProductCategoryEntity? category;

  Map<String, dynamic> toEntityMap() {
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
    this.properties,
    this.category,
    this.variations,
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
    );
  }
}
