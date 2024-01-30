import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ismart/core/dtos/product_list_model.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/repository/abstractions/i_products_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductListProvider extends ChangeNotifier {
  final IProductsRepository _repository = IProductsRepository.getInstance();
  final BehaviorSubject<List<Group<ProductListModel>>> _productsStreamController = BehaviorSubject();

  Future<List<Group<ProductListModel>>> _loadData() async {
    return [];
  }
}
