import 'package:uuid/uuid.dart';

class ProductCategoryEntity {
  final String productCategoryId;
  final String name;
  final String groupId;

  ProductCategoryEntity({
    required this.productCategoryId,
    required this.name,
    required this.groupId,
  });

  Map<String, String> toMap() {
    return {
      "product_category_id": productCategoryId,
      "name": name,
      "product_group_id": groupId,
    };
  }

  factory ProductCategoryEntity.create({required String name, required String groupId}) {
    return ProductCategoryEntity(
      productCategoryId: const Uuid().v4(),
      name: name,
      groupId: groupId,
    );
  }

  factory ProductCategoryEntity.fromMap(Map<String, Object?> map) {
    return ProductCategoryEntity(
      productCategoryId: map["product_category_id"]?.toString() ?? '',
      name: map["name"]?.toString() ?? '',
      groupId: map["group_id"]?.toString() ?? '',
    );
  }
}
