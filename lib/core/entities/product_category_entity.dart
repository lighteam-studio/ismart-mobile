import 'package:uuid/uuid.dart';

class ProductCategoryEntity {
  final String productCategoryId;
  String name;
  String productGroupId;

  ProductCategoryEntity({
    required this.productCategoryId,
    required this.name,
    required this.productGroupId,
  });

  Map<String, String> toEntityMap() {
    return {
      "product_category_id": productCategoryId,
      "name": name,
      "product_group_id": productGroupId,
    };
  }

  factory ProductCategoryEntity.create({required String name, required String productGroupId}) {
    return ProductCategoryEntity(
      productCategoryId: const Uuid().v4(),
      name: name,
      productGroupId: productGroupId,
    );
  }

  factory ProductCategoryEntity.fromMap(Map<String, dynamic> map) {
    return ProductCategoryEntity(
      productCategoryId: map["product_category_id"] ?? '',
      name: map["name"] ?? '',
      productGroupId: map["product_group_id"] ?? '',
    );
  }
}
