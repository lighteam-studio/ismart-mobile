import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_property_type.dart';

class ProductPropertyProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  late ProductPropertyType _propertyType;
  ProductPropertyType get propertyType => _propertyType;
  set propertyType(ProductPropertyType type) {
    _propertyType = type;
    notifyListeners();
  }

  ProductPropertyProvider({ProductPropertyType type = ProductPropertyType.base}) {
    _propertyType = type;
  }
}
