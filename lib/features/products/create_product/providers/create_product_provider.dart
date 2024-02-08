import 'package:flutter/material.dart';
import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/utils/helper_functions.dart';
import 'package:uuid/v4.dart';

class CreateProductProvider extends ChangeNotifier {
  final GlobalKey<FormState> _productInfoForm = GlobalKey();
  GlobalKey<FormState> get productInfoForm => _productInfoForm;

  bool _validateOnInput = false;
  bool get validateOnInput => _validateOnInput;

  final IProductGroupRepository _productGroupsRepository = IProductGroupRepository.getInstance();

  /// Available product groups
  List<Group<Option<String>>> _availableProductGroups = [];
  List<Group<Option<String>>> get availableProductGroups => _availableProductGroups;

  final String _productId = const UuidV4().generate();

  late final ProductEntity _entity = ProductEntity(
    productId: _productId,
    categoryId: '',
    brand: '',
    unit: ProductUnit.un,
    name: '',
    barcodes: [
      ProductBarcodeEntity(
        productBarcodeId: const UuidV4().generate(),
        productId: _productId,
        value: "",
      )
    ],
  );

  String get name => _entity.name;
  set name(String value) {
    _entity.name = value;
    notifyListeners();
  }

  String get brand => _entity.brand;
  set brand(String value) {
    _entity.brand = value;
    notifyListeners();
  }

  ProductUnit get unit => _entity.unit;
  set unit(ProductUnit value) {
    _entity.unit = value;
    notifyListeners();
  }

  String get category => _entity.categoryId;
  set category(String value) {
    _entity.categoryId = value;
    notifyListeners();
  }

  List<ProductBarcodeEntity> get barcodes => _entity.barcodes!;

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
      var groups = await _productGroupsRepository.select();

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
    _entity.barcodes!.add(ProductBarcodeEntity(
      productBarcodeId: const UuidV4().generate(),
      productId: _productId,
      value: "",
    ));
    notifyListeners();
  }

  /// Remove bar code
  void removeBarCode(int index) {
    _entity.barcodes!.removeAt(index);
    notifyListeners();
  }

  void editBarcode(int index, String value) {
    _entity.barcodes![index].value = value;
    notifyListeners();
  }

  /// Submit product information form
  void submitProductInfoForm() {
    _validateOnInput = true;
    notifyListeners();
    var isValid = _productInfoForm.currentState?.validate() ?? false;
    print(isValid);
  }
}
