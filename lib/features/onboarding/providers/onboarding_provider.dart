import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/models/product_group_model.dart';
import 'package:ismart/mock/models/product_group_model_mock.dart';

class OnboardingProvider extends ChangeNotifier {
  ///
  /// Page controller
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  /// Lista de groups
  final List<ProductGroupModel> _availableProductGroups = generateProductGroupModelMock();
  List<ProductGroupModel> get availableProductGroups => _availableProductGroups;

  /// Selected groups
  final List<String> _selectedTemplateGroups = [];
  List<String> get selectedTemplateGroups => _selectedTemplateGroups;

  /// Final list of products that will be persisted in the database
  List<ProductGroupModel> _selectedGroups = [];
  List<ProductGroupModel> get selectedGroups => _selectedGroups;

  /// Toogle selected group
  void toogleSelectedGroup(String groupId) {
    _selectedTemplateGroups.contains(groupId)
        ? _selectedTemplateGroups.remove(groupId) //
        : _selectedTemplateGroups.add(groupId);
    notifyListeners();
  }

  /// Confirm Selected group
  void confirmSelectedGroups() {
    // Clear unselected groups
    _selectedGroups = _selectedGroups
        .where((element) => _selectedTemplateGroups.contains(element.id)) //
        .toList();

    // Add groups to selected groups if it does not exist
    for (var id in _selectedTemplateGroups) {
      var groupAlreadyInSelectedGroups = _selectedGroups.firstWhereOrNull((element) => element.id == id);
      if (groupAlreadyInSelectedGroups != null) break;

      var group = _availableProductGroups.firstWhere((element) => element.id == id);
      _selectedGroups.add(group.clone());
    }
    notifyListeners();

    // Navigate to next page
    _pageController.animateToPage(
      ((_pageController.page ?? 0) + 1).round(),
      duration: const Duration(milliseconds: 150),
      curve: Curves.ease,
    );
  }

  /// Remove selected group
  void removeSeletedGroup(String id) {
    _selectedTemplateGroups.remove(id);
    _selectedGroups.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
