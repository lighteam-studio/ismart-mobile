import 'package:collection/collection.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/entities/product_property_entity.dart';
import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/entities/product_variation_property_value_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/features/products/create_product/components/product_property_dialog.dart';
import 'package:ismart/features/products/create_product/components/product_variation_dialog.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/repository/abstractions/i_products_repository.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/utils/helper_functions.dart';
import 'package:uuid/uuid.dart';

class CreateProductProvider extends ChangeNotifier {
  /// Repositories
  late final IProductsRepository _productsRepository = IProductsRepository.getInstance();
  final IProductGroupRepository _productGroupRepository = IProductGroupRepository.getInstance();

  /// Form keys
  final GlobalKey<FormState> _productInfoForm = GlobalKey();
  GlobalKey<FormState> get productInfoForm => _productInfoForm;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  bool _validateOnInput = false;
  bool get validateOnInput => _validateOnInput;

  /// Available product groups
  List<Group<Option<String>>> _availableProductGroups = [];
  List<Group<Option<String>>> get availableProductGroups => _availableProductGroups;

  /// Pictures
  List<MediaEntity> _pictures = [];
  List<MediaEntity> get pictures => _pictures;
  set pictures(List<MediaEntity> pictures) {
    _pictures = pictures;
    notifyListeners();
  }

  /// Temp product id
  String _tempProductId = const Uuid().v4();

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

  List<TextEditingController> _barcodes = [TextEditingController()];
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

  /// Price controller
  final TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;

  /// Currency
  final CurrencyTextInputFormatter _currencyFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: "€ ",
  );
  CurrencyTextInputFormatter get currencyFormatter => _currencyFormatter;

  /// Stock controller
  final TextEditingController _stockController = TextEditingController();
  TextEditingController get stockController => _stockController;

  bool get canAddProperty => _productProperties.length < 3;

  CreateProductProvider(BuildContext context) {
    _loadAvailableProductGroups(context);
  }

  void _loadAvailableProductGroups(BuildContext context) async {
    try {
      var groups = await _productGroupRepository.getGroups();

      _availableProductGroups = groups.map<Group<Option<String>>>((e) {
        return Group(
          title: e.title,
          items: e.categories!
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
    _pictures.clear();
    _barcodes = [TextEditingController()];
    _validateOnInput = false;
    _productProperties.clear();
    _variations.clear();
    _selectedCategory = '';
    _productHasVariations = false;
    _tempProductId = const Uuid().v4();
    _priceController.clear();
    _stockController.clear();
    _pageController.jumpToPage(0);
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
    _priceController.clear();
    _stockController.clear();

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

    if (_productHasVariations && _productProperties.isEmpty) {
      showAlertHelper(
        context,
        description: "Please, add some characteristics to this product",
      );

      return;
    }

    var valueMatrix = _productProperties.map((e) => e.propertyValues).toList();
    var cartesian = createCartesianMatrix(valueMatrix);

    _variations = cartesian.map(
      (combination) {
        var variationId = const Uuid().v4();

        return ProductVariationEntity(
          sku: "",
          thumbnail: null,
          variationId: variationId,
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

    if (_productHasVariations) {
      pageController.nextPage(duration: const Duration(milliseconds: 150), curve: Curves.ease);
      return;
    }

    createProduct(context);
  }

  /// Back to product form page
  void backToFormPage() {
    pageController.previousPage(duration: const Duration(milliseconds: 150), curve: Curves.ease);
  }

  /// Edit variation
  void editVariation(BuildContext context, ProductVariationEntity variation) async {
    var newVariation = await showBottomSheetHelper(
      context,
      child: ProductVariationDialog(variation: variation),
    );

    if (newVariation is ProductVariationEntity) {
      _variations[_variations.indexOf(variation)] = newVariation;
      notifyListeners();
    }
  }

  /// Submit product information form
  void createProduct(BuildContext context) async {
    try {
      const uuid = Uuid();

      // Add the entity
      var entity = ProductEntity(
        productId: _tempProductId,
        categoryId: _selectedCategory,
        brand: _brandController.text,
        unit: _unit,
        name: _nameController.text,
        properties: _productProperties
            .map(
              (e) => ProductPropertyEntity(
                productId: _tempProductId,
                name: e.name,
                propertyId: uuid.v4(),
                type: e.type,
                propertyValues: e.propertyValues,
              ),
            )
            .toList(),
        variations: _productHasVariations
            ? _variations
            : [
                ProductVariationEntity(
                  sku: "",
                  thumbnail: null,
                  price: _currencyFormatter.getUnformattedValue().toDouble(),
                  productId: _tempProductId,
                  stock: double.tryParse(_stockController.text) ?? 0,
                  variationId: uuid.v4(),
                )
              ],
      );
      await _productsRepository.addProduct(entity);

      scrollController.jumpTo(0);

      showAlertHelper(
        context,
        image: AppImages.success,
        title: "Success!",
        description: "The product was created successfully",
      );

      clearForm();
    } catch (e) {
      showAlertHelper(
        context,
        description: "It was not possible create the product, try again later",
      );
    }
  }
}
