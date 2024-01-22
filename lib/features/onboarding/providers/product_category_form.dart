import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/models/product_group_model.dart';
import 'package:ismart/mock/models/product_group_model_mock.dart';

class ProductCategoryForm extends ChangeNotifier {
  final TextEditingController _newGroupController = TextEditingController();
  TextEditingController get newGroupController => _newGroupController;

  /// Lista de groups
  final List<ProductGroupModel> _availableProductGroups = generateProductGroupModelMock();
  List<ProductGroupModel> get availableProductGroups => _availableProductGroups;

  /// Selected groups
  final List<String> _selectedTemplateGroups = [];
  List<String> get selectedTemplateGroups => _selectedTemplateGroups;

  /// Final list of products that will be persisted in the database
  List<ProductGroupModel> _productGroups = [];
  List<ProductGroupModel> get productGroups => _productGroups;

  /// Toogle selected group
  void toogleSelectedGroup(String groupId) {
    _selectedTemplateGroups.contains(groupId)
        ? _selectedTemplateGroups.remove(groupId) //
        : _selectedTemplateGroups.add(groupId);
    notifyListeners();
  }

  /// Remove selected group
  void removeSeletedGroup(String id) {
    _selectedTemplateGroups.remove(id);
    _productGroups.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  /// Confirm Selected group
  void confirmSelectedGroups() {
    // Clear unselected groups
    _productGroups = _productGroups
        .where((element) => _selectedTemplateGroups.contains(element.id) || element.id.isEmpty) //
        .toList();

    // Add groups to selected groups if it does not exist
    for (var id in _selectedTemplateGroups) {
      var groupAlreadyInSelectedGroups = _productGroups.firstWhereOrNull((element) => element.id == id);
      if (groupAlreadyInSelectedGroups != null) continue;

      var group = _availableProductGroups.firstWhere((element) => element.id == id);
      _productGroups.add(group.clone());
    }
    notifyListeners();
  }

  /// Add new group
  void addNewGroup(BuildContext context) {
    if (_newGroupController.text.isEmpty) return;

    var groupAlreadyExists = _productGroups.firstWhereOrNull(
          (element) => element.title.toLowerCase() == _newGroupController.text.toLowerCase(),
        ) !=
        null;

    if (groupAlreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Já existe uma categoria de produtos com este título"),
      ));
      return;
    }

    _productGroups.add(ProductGroupModel(id: "", icon: "", categories: [], title: _newGroupController.text));
    notifyListeners();
    _newGroupController.clear();
  }
}
