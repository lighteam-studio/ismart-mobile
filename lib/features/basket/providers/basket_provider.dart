import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/models/basket_item_model.dart';
import 'package:ismart/core/models/product_variation_model.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/repository/abstractions/product_variation_repository.dart';
import 'package:ismart/router/app_router.dart';
import 'package:rxdart/rxdart.dart';

class BasketProvider extends ChangeNotifier {
  /// Product variation repository
  final ProductVariationRepository _repository = ProductVariationRepository.getInstance();

  /// Product search controller
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  /// Product list controller
  final BehaviorSubject<List<ProductVariationModel>> _productController = BehaviorSubject();
  Stream<List<ProductVariationModel>> get productsStream => _productController.stream;

  final List<BasketItemModel> _basketItems = [];
  List<BasketItemModel> get basketItems => _basketItems;

  int get totalItems => _basketItems.fold<int>(
        0,
        (previousValue, element) {
          return element.unit == ProductUnit.un
              ? (previousValue + element.amount.toInt()) //
              : previousValue + 1;
        },
      );

  double get totalValue => _basketItems.fold(
        0,
        (previousValue, element) => previousValue + (element.amount * element.price),
      );

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

    var item = _basketItems.firstWhereOrNull((element) => element.variationId == product.variationId);

    if (item == null) {
      _basketItems.add(BasketItemModel.fromProductVariation(product));
      return;
    } else if (item.amount + 1 < item.stock) {
      item.amount += 1;
    }
    notifyListeners();
  }

  void removeProductFrombasket(int index) {
    _basketItems.removeAt(index);
    notifyListeners();
  }

  void changeAmount(int index, double amount) {
    _basketItems[index].amount = amount;
    notifyListeners();
  }

  void createTransaction(BuildContext context) {
    Navigator.of(context).pushNamed(AppRouter.payment);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _productController.close();
    super.dispose();
  }
}
