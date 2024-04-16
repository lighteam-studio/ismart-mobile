import 'package:flutter/material.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/mock/models/product_group_model_mock.dart';
import 'package:ismart/repository/abstractions/product_group_repository.dart';
import 'package:ismart/utils/helper_functions.dart';

class ProductCategoryForm extends ChangeNotifier {
  final ProductGroupRepository _productGroupRepository = ProductGroupRepository.getInstance();

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
  Future<bool> persistSelectedGroups(BuildContext context) async {
    if (_loading) return false;

    try {
      _loading = true;
      await _productGroupRepository.createGroups(
        _availableProductGroups
            .where((group) => _selectedTemplateGroups.contains(group.productGroupId)) //
            .toList(),
      );

      return true;
    } catch (e) {
      showSnackBar(context, "It was not possible to add the categories, please, try again later");
      return false;
    } finally {
      _loading = false;
    }
  }
}
