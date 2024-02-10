import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/dtos/product_list_model.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/repository/abstractions/i_products_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductListProvider extends ChangeNotifier {
  final IProductsRepository _repository = IProductsRepository.getInstance();

  /// Product list stream controller
  late final BehaviorSubject<List<Group<ProductListModel>>> _productsStreamController;
  Stream<List<Group<ProductListModel>>> get productsListStream => _productsStreamController.stream;

  /// Product search query
  final Query _query = Query();

  /// Get current products
  Future<List<Group<ProductListModel>>> _loadData() async {
    var products = await _repository.searchProducts(_query);
    var groupedProducts = groupBy(products, (p0) => p0.name[0]);

    return groupedProducts.entries
        .map((e) => Group(
              title: e.key,
              items: e.value
                  .map((e) => ProductListModel(
                        name: e.name,
                        brand: e.brand,
                      ))
                  .toList(),
            ))
        .toList();
  }

  void _refresh() async {
    try {
      var products = await _loadData();
      _productsStreamController.sink.add(products);
    } catch (e) {
      _productsStreamController.sink.addError(e);
    }
  }

  ProductListProvider() {
    _productsStreamController = BehaviorSubject(
      onListen: _refresh,
    );
  }
}
