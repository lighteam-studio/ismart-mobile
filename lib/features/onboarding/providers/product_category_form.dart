import 'package:flutter/material.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/mock/models/product_group_model_mock.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';

class ProductCategoryForm extends ChangeNotifier {
  final IProductGroupRepository _productGroupRepository = IProductGroupRepository.getInstance();

  bool _loading = false;

  /// Lista de groups
  final List<ProductGroupEntity> _availableProductGroups = generateProductGroupEntityMock();
  List<ProductGroupEntity> get availableProductGroups => _availableProductGroups;

  /// Selected groups
  final List<String> _selectedTemplateGroups = [];
  List<String> get selectedTemplateGroups => _selectedTemplateGroups;

  /// Toogle selected group
  void toogleSelectedGroup(String groupId) {
    _selectedTemplateGroups.contains(groupId)
        ? _selectedTemplateGroups.remove(groupId) //
        : _selectedTemplateGroups.add(groupId);
    notifyListeners();
  }

  /// persist selected groups
  void persistSelectedGroups() async {
    if (_loading) return;

    try {
      _loading = true;
      await _productGroupRepository.batchInsert(
        _availableProductGroups.where((group) => _selectedTemplateGroups.contains(group.id)).toList(),
      );
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
    }
  }
}
