import 'package:uuid/uuid.dart';

class ProductGroupEntity {
  final String id;
  final String title;

  ProductGroupEntity({
    required this.id,
    required this.title,
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
