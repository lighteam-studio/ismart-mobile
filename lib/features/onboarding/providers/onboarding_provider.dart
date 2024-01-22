import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/features/onboarding/providers/company_name_form.dart';
import 'package:ismart/features/onboarding/providers/product_category_form.dart';

class OnboardingProvider extends ChangeNotifier {
  ///
  /// Page controller
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  final CompanyNameForm _companyNameForm = CompanyNameForm();
  CompanyNameForm get companyNameForm => _companyNameForm;

  final ProductCategoryForm _productCategoryForm = ProductCategoryForm();
  ProductCategoryForm get productCategoryForm => _productCategoryForm;

  /// Set company name
  void setCompanyName() {
    _companyNameForm.validateOnInput = true;

    var isValid = _companyNameForm.shopNameForm.currentState?.validate() ?? false;
    if (!isValid) return;

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  /// Set selected groups
  void setSelectedGroups() {
    _productCategoryForm.confirmSelectedGroups();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void setSelectedCategories(BuildContext context) {
    var invalidGroup = _productCategoryForm.productGroups.firstWhereOrNull((element) => element.title.isEmpty);
    if (invalidGroup != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Existem grupos de produtos com o título não preenchido"),
      ));
      return;
    }

    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
