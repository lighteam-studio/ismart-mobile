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
  void setCompanyName() async {
    var isValid = await _companyNameForm.updateCompanyName();
    if (!isValid) return;

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  /// Set selected groups
  void setSelectedGroups() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void setSelectedCategories(BuildContext context) async {}
}
