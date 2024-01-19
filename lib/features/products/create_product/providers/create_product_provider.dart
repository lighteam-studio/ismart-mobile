import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_unit.dart';

class CreateProductProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  ///
  /// Selected Category
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;
  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  ///
  /// Selected Unit
  ProductUnit? _unit;
  ProductUnit? get unit => _unit;
  set unit(ProductUnit? value) {
    _unit = value;
    notifyListeners();
  }

  ///
  /// Product has variations
  bool _productHasVariations = false;
  bool get productHasVariations => _productHasVariations;
  set productHasVariations(bool value) {
    _productHasVariations = value;
    notifyListeners();
  }

  ///
  /// Bar Codes
  final List<TextEditingController> _barCodes = [TextEditingController()];
  List<TextEditingController> get barCodes => _barCodes;

  ///
  /// Pictures
  final List<String> _pictures = [];
  List<String> get pictures => _pictures;

  ///
  /// Add new Pictures to the product
  void addPictures(List<String> newPictures) {
    _pictures.addAll(newPictures);
    notifyListeners();
  }

  ///
  /// Remove picture from list
  void removePicture(int index) {
    _pictures.removeAt(index);
    notifyListeners();
  }

  void addBarCode() {
    _barCodes.add(TextEditingController());
    notifyListeners();
  }

  void removeBarCode(int index) {
    _barCodes.removeAt(index);
    notifyListeners();
  }
}
