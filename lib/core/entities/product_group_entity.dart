import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:uuid/uuid.dart';

class ProductGroupEntity {
  final String id;
  final String title;

  // Relationship fields
  List<ProductCategoryEntity>? categories;

  ProductGroupEntity({
    required this.id,
    required this.title,
    this.categories,
  });

  factory ProductGroupEntity.create({required String title}) {
    return ProductGroupEntity(
      id: const Uuid().v4(),
      title: title,
    );
  }

  Map<String, String> toMap() {
    return {
      "id": id,
      "title": title,
    };
  }
}
