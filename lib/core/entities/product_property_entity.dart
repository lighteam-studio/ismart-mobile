import 'dart:convert';

import 'package:ismart/core/enums/product_property_type.dart';

class ProductPropertyEntity {
  String propertyId;
  ProductPropertyType type;
  String name;
  String productId;
  List<String> propertyValues;

  ProductPropertyEntity({
    required this.productId,
    required this.name,
    required this.propertyId,
    required this.type,
    required this.propertyValues,
  });

  Map<String, dynamic> toEntityMap() {
    return {
      "property_id": propertyId,
      "type": type.name,
      "name": name,
      "product_id": productId,
      "property_values": jsonEncode(propertyValues),
    };
  }

  factory ProductPropertyEntity.fromMap(Map<String, dynamic> map) {
    return ProductPropertyEntity(
      productId: map['product_id'],
      name: map['name'],
      propertyId: map['property_id'],
      propertyValues: jsonDecode(map['property_values']),
      type: ProductPropertyType.values.firstWhere(
        (element) => element.name == map['type'],
        orElse: () => ProductPropertyType.text,
      ),
    );
  }
}
