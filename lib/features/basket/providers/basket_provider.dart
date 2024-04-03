import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/models/product_variation_model.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/features/basket/providers/basket_item_provider.dart';
import 'package:ismart/repository/abstractions/i_product_variation_repository.dart';
import 'package:rxdart/rxdart.dart';

class BasketProvider extends ChangeNotifier {
  /// Product variation repository
  final IProductVariationRepository _repository = IProductVariationRepository.getInstance();

  /// Product search controller
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  /// Product list controller
  final BehaviorSubject<List<ProductVariationModel>> _productController = BehaviorSubject();
  Stream<List<ProductVariationModel>> get productsStream => _productController.stream;

  final List<BasketItemProvider> _basketItems = [];
  List<BasketItemProvider> get basketItems => _basketItems;

  void _getProducts() async {
    try {
      var products = await _repository.getProductVariations(Query(search: _searchController.text));
      _productController.sink.add(products);
    } catch (e) {
      _productController.sink.addError(e);
    }
  }

  void _initialize() {
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        _getProducts();
      }
    });
  }

  BasketProvider() {
    _initialize();
  }

  void addProductToBasket(ProductVariationModel product) {
    _searchController.clear();
    notifyListeners();

    var item = _basketItems.firstWhereOrNull((element) => element.product.variationId == product.variationId);
    if (item == null) {
      _basketItems.add(BasketItemProvider(product));
      return;
    }
    item.increment();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _productController.close();
    super.dispose();
  }
}
