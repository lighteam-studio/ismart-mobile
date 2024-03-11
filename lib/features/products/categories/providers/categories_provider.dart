import 'package:flutter/material.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesProvider extends ChangeNotifier {
  final IProductGroupRepository _repository = IProductGroupRepository.getInstance();

  /// Categories Stream
  late BehaviorSubject<List<ProductGroupEntity>> _groupsController;
  Stream<List<ProductGroupEntity>> get groupsStream => _groupsController.stream;

  /// Load categories
  void _loadCategories() async {
    try {
      var response = await _repository.getGroups();
      _groupsController.sink.add(response);
    } catch (e) {
      _groupsController.sink.addError(e);
    }
  }

  CategoriesProvider() {
    _groupsController = BehaviorSubject(onListen: _loadCategories);
  }

  @override
  void dispose() {
    _groupsController.close();
    super.dispose();
  }
}
