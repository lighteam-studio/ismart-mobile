import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/utils/helper_functions.dart';

class CreateProductProvider extends ChangeNotifier {
  final IProductGroupRepository _productGroupsRepository = IProductGroupRepository.getInstance();

  /// Available product groups
  List<Group<Option<String>>> _availableProductGroups = [];
  List<Group<Option<String>>> get availableProductGroups => _availableProductGroups;

  /// Product name controller
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  /// Selected Category
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;
  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  /// Selected Unit
  ProductUnit? _unit;
  ProductUnit? get unit => _unit;
  set unit(ProductUnit? value) {
    _unit = value;
    notifyListeners();
  }

  /// Product has variations
  bool _productHasVariations = false;
  bool get productHasVariations => _productHasVariations;
  set productHasVariations(bool value) {
    _productHasVariations = value;
    notifyListeners();
  }

  /// Bar Codes
  final List<TextEditingController> _barCodes = [TextEditingController()];
  List<TextEditingController> get barCodes => _barCodes;

  /// Pictures
  final List<String> _pictures = [];
  List<String> get pictures => _pictures;

  CreateProductProvider(BuildContext context) {
    _loadAvailableProductGroups(context);
  }

  void _loadAvailableProductGroups(BuildContext context) async {
    try {
      var groups = await _productGroupsRepository.select();
    } catch (e) {
      showSnackBar(context, "Não foi possível carregar as categorias de produtos, tente novamente em breve");
    }
  }

  /// Add new Pictures to the product
  void addPictures(List<String> newPictures) {
    _pictures.addAll(newPictures);
    notifyListeners();
  }

  /// Remove picture from list
  void removePicture(int index) {
    _pictures.removeAt(index);
    notifyListeners();
  }

  /// Add bar code
  void addBarCode() {
    _barCodes.add(TextEditingController());
    notifyListeners();
  }

  /// Remove bar code
  void removeBarCode(int index) {
    _barCodes.removeAt(index);
    notifyListeners();
  }
}
