import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/entities/product_property_entity.dart';
import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/entities/product_variation_property_value_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/features/products/create_product/components/product_property_dialog.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/repository/abstractions/i_products_repository.dart';
import 'package:ismart/utils/helper_functions.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';

class CreateProductProvider extends ChangeNotifier {
  /// Repositories
  late final IProductsRepository _productsRepository = IProductsRepository.getInstance();
  final IProductGroupRepository _productGroupsRepository = IProductGroupRepository.getInstance();

  /// Form keys
  final GlobalKey<FormState> _productInfoForm = GlobalKey();
  GlobalKey<FormState> get productInfoForm => _productInfoForm;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  bool _validateOnInput = false;
  bool get validateOnInput => _validateOnInput;

  /// Available product groups
  List<Group<Option<String>>> _availableProductGroups = [];
  List<Group<Option<String>>> get availableProductGroups => _availableProductGroups;

  /// Pictures
  final List<String> _pictures = [];
  List<String> get pictures => _pictures;

  /// Temp product id
  String _tempProductId = Uuid().v4();

  /// Selected category
  String _selectedCategory = "";
  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

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

  final List<TextEditingController> _barcodes = [TextEditingController()];
  List<TextEditingController> get barcodes => _barcodes;

  /// Product has variations
  bool _productHasVariations = false;
  bool get productHasVariations => _productHasVariations;

  /// Product properties
  List<ProductPropertyEntity> _productProperties = [];
  List<ProductPropertyEntity> get productProperties => _productProperties;

  /// Product variation
  List<ProductVariationEntity> _variations = [];
  List<ProductVariationEntity> get variations => _variations;

  bool get canAddProperty => _productProperties.length < 3;

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

  /// Set product has variations
  void setProductHasVariations(bool hasVariations) {
    _productProperties = [];
    _productHasVariations = hasVariations;
    notifyListeners();
  }

  /// Add new property to product
  void addProperty(BuildContext context) async {
    var response = await showBottomSheetHelper<ProductPropertyEntity>(
      context,
      child: const ProductPropertyDialog(),
    );

    if (response is ProductPropertyEntity) {
      _productProperties.add(response);
      notifyListeners();
    }
  }

  /// Edit product property
  void editProperty(BuildContext context, ProductPropertyEntity property) async {
    var response = await showBottomSheetHelper(
      context,
      child: ProductPropertyDialog(
        property: property,
      ),
    );

    if (response == ProductPropertyDialogAction.delete) {
      _productProperties.remove(property);
      notifyListeners();
    }

    if (response is ProductPropertyEntity) {
      _productProperties.add(response);
      notifyListeners();
    }
  }

  /// Submit form data
  void submitProductInfoForm(BuildContext context) {
    FocusScope.of(context).unfocus();
    _validateOnInput = true;
    notifyListeners();

    // Validate form
    var isValid = _productInfoForm.currentState?.validate() ?? false;
    if (!isValid) return;

    var valueMatrix = _productProperties.map((e) => e.propertyValues).toList();
    var cartesian = createCartesianMatrix(valueMatrix);

    _variations = cartesian.map(
      (combination) {
        var variationId = const Uuid().v4();

        return ProductVariationEntity(
          id: variationId,
          productId: _tempProductId,
          price: 0,
          stock: 0,
          values: combination
              .mapIndexed(
                (i, value) => ProductVariationPropertyValueEntity(
                  value: value,
                  propertyId: _productProperties[i].propertyId,
                  valueId: const Uuid().v4(),
                  variationId: variationId,
                ),
              )
              .toList(),
        );
      },
    ).toList();
    notifyListeners();

    pageController.nextPage(duration: const Duration(milliseconds: 150), curve: Curves.ease);
  }

  void backToFormPage() {
    pageController.previousPage(duration: Duration(milliseconds: 150), curve: Curves.ease);
  }

  /// Submit product information form
  void createProduct() async {
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
      properties: _productProperties
          .map(
            (e) => ProductPropertyEntity(
              productId: productId,
              name: e.name,
              propertyId: uuid.v4(),
              type: e.type,
              propertyValues: e.propertyValues,
            ),
          )
          .toList(),
      images: _pictures
          .mapIndexed(
            (index, element) => ProductImageEntity(
              productImageId: uuid.v4(),
              data: imageBlobs[index],
              mimeType: lookupMimeType(element) ?? '',
              productId: productId,
            ),
          )
          .toList(),
      barcodes: _barcodes
          .where((element) => element.text.isNotEmpty)
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
