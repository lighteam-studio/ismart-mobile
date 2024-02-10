import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/repository/abstractions/i_products_repository.dart';
import 'package:ismart/utils/helper_functions.dart';
import 'package:uuid/uuid.dart';

class CreateProductProvider extends ChangeNotifier {
  late final IProductsRepository _productsRepository = IProductsRepository.getInstance();

  final GlobalKey<FormState> _productInfoForm = GlobalKey();
  GlobalKey<FormState> get productInfoForm => _productInfoForm;

  bool _validateOnInput = false;
  bool get validateOnInput => _validateOnInput;

  final IProductGroupRepository _productGroupsRepository = IProductGroupRepository.getInstance();

  /// Available product groups
  List<Group<Option<String>>> _availableProductGroups = [];
  List<Group<Option<String>>> get availableProductGroups => _availableProductGroups;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _brandController = TextEditingController();
  TextEditingController get brandController => _brandController;

  ProductUnit _unit = ProductUnit.un;
  ProductUnit get unit => _unit;
  set unit(ProductUnit value) {
    _unit = value;
    notifyListeners();
  }

  String _selectedCategory = "";
  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  final List<TextEditingController> _barcodes = [TextEditingController()];
  List<TextEditingController> get barcodes => _barcodes;

  /// Product has variations
  bool _productHasVariations = false;
  bool get productHasVariations => _productHasVariations;
  set productHasVariations(bool value) {
    _productHasVariations = value;
    notifyListeners();
  }

  /// Pictures
  final List<String> _pictures = [];
  List<String> get pictures => _pictures;

  CreateProductProvider(BuildContext context) {
    _loadAvailableProductGroups(context);
  }

  void _loadAvailableProductGroups(BuildContext context) async {
    try {
      var groups = await _productGroupsRepository.getGroups();

      _availableProductGroups = groups.map<Group<Option<String>>>((e) {
        return Group(
          title: e.title,
          items: e.categories
              .map<Option<String>>(
                (e) => Option(key: e.productCategoryId, label: e.name),
              )
              .toList(),
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      showSnackBar(context, "Não foi possível carregar as categorias de produtos, tente novamente em breve");
    }
  }

  void clearForm() {
    _nameController.clear();
    _brandController.clear();
    _barcodes.clear();
    _pictures.clear();
    _barcodes.add(TextEditingController());
    _validateOnInput = false;
    notifyListeners();
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
    _barcodes.add(TextEditingController());
    notifyListeners();
  }

  /// Remove bar code
  void removeBarCode(int index) {
    _barcodes.removeAt(index);
    notifyListeners();
  }

  /// Submit product information form
  void submitProductInfoForm() async {
    _validateOnInput = true;
    notifyListeners();

    // Validate form
    var isValid = _productInfoForm.currentState?.validate() ?? false;
    if (!isValid) return;

    const uuid = Uuid();
    var productId = uuid.v4();

    var imageBlobs = await Future.wait(
      _pictures.map((picture) => File(picture).readAsBytes()),
    );

    // Add the entity
    var entity = ProductEntity(
      productId: productId,
      categoryId: _selectedCategory,
      brand: _brandController.text,
      unit: _unit,
      name: _nameController.text,
      images: [],
      barcodes: _barcodes
          .map(
            (e) => ProductBarcodeEntity(
              productBarcodeId: uuid.v4(),
              productId: productId,
              value: e.text,
            ),
          )
          .toList(),
    );
    await _productsRepository.addProduct(entity);

    clearForm();
  }
}
