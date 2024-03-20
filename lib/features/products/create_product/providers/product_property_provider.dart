import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_property_type.dart';

class ProductPropertyProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  List<TextEditingController> _values = [
    TextEditingController(),
  ];
  List<TextEditingController> get values => _values;

  late ProductPropertyType _type;
  ProductPropertyType get type => _type;
  set type(ProductPropertyType type) {
    _type = type;
    _values = [TextEditingController()];
    notifyListeners();
  }

  addValue() {
    _values.add(TextEditingController());
    notifyListeners();
  }

  removeValue(int index) {
    _values.removeAt(index);
    notifyListeners();
  }

  ProductPropertyProvider({ProductPropertyType type = ProductPropertyType.base}) {
    _type = type;
  }
}
