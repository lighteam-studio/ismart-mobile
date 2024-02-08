import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:uuid/uuid.dart';

class ProductGroupEntity {
  final String productGroupId;
  final String title;

  // Relationship fields
  List<ProductCategoryEntity> categories;

  ProductGroupEntity({
    required this.productGroupId,
    required this.title,
    required this.categories,
  });

  factory ProductGroupEntity.create({required String title}) {
    return ProductGroupEntity(
      productGroupId: const Uuid().v4(),
      title: title,
      categories: [],
    );
  }

  factory ProductGroupEntity.fromMap(Map<String, Object?> map) {
    return ProductGroupEntity(
      productGroupId: map["product_group_id"]?.toString() ?? '',
      title: map["title"]?.toString() ?? '',
      categories: List.from(map['categories'] as List)
          .map(
            (category) => ProductCategoryEntity.fromMap(category),
          )
          .toList(),
    );
  }

  Map<String, String> toMap() {
    return {
      "product_group_id": productGroupId,
      "title": title,
    };
  }
}
