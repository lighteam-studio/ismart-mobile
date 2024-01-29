import 'package:uuid/uuid.dart';

class ProductCategoryEntity {
  final String id;
  final String name;
  final String groupId;

  ProductCategoryEntity({
    required this.id,
    required this.name,
    required this.groupId,
  });

  Map<String, String> toMap() {
    return {
      "id": id,
      "name": name,
      "group_id": groupId,
    };
  }

  factory ProductCategoryEntity.create({required String name, required String groupId}) {
    return ProductCategoryEntity(
      id: const Uuid().v4(),
      name: name,
      groupId: groupId,
    );
  }
}
