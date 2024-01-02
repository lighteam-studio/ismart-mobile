import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_unit.dart';

class CreateProductProvider extends ChangeNotifier {
  ///
  /// Selected Category
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;
  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  ///
  /// Selected Category
  ProductUnit? _unit;
  ProductUnit? get unit => _unit;
  set unit(ProductUnit? value) {
    _unit = value;
    notifyListeners();
  }

  bool _productHasVariations = false;
  bool get productHasVariations => _productHasVariations;
  set productHasVariations(bool value) {
    _productHasVariations = value;
    notifyListeners();
  }

  final List<TextEditingController> _barCodes = [
    TextEditingController(),
  ];
  List<TextEditingController> get barCodes => _barCodes;

  void addBarCode() {
    _barCodes.add(TextEditingController());
    notifyListeners();
  }

  void removeBarCode(int index) {
    _barCodes.removeAt(index);
    notifyListeners();
  }
}
