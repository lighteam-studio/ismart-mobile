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

  Map<String, String> toMap() {
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

  factory ProductCategoryEntity.fromMap(Map<String, Object?> map) {
    return ProductCategoryEntity(
      productCategoryId: map["product_category_id"]?.toString() ?? '',
      name: map["name"]?.toString() ?? '',
      productGroupId: map["product_group_id"]?.toString() ?? '',
    );
  }
}
