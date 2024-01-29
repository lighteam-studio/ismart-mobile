import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/features/onboarding/providers/company_name_form.dart';
import 'package:ismart/features/onboarding/providers/product_category_form.dart';
import 'package:ismart/features/products/create_product/providers/create_product_provider.dart';
import 'package:ismart/utils/helper_functions.dart';

class OnboardingProvider extends ChangeNotifier {
  ///
  /// Page controller
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  final CompanyNameForm _companyNameForm = CompanyNameForm();
  CompanyNameForm get companyNameForm => _companyNameForm;

  final ProductCategoryForm _productCategoryForm = ProductCategoryForm();
  ProductCategoryForm get productCategoryForm => _productCategoryForm;

  final CreateProductProvider _productForm = CreateProductProvider();
  CreateProductProvider get productForm => _productForm;

  Future _createDatabase() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return Future.error("123");
  }

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
    _productCategoryForm.confirmSelectedGroups();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void setSelectedCategories(BuildContext context) async {
    var invalidGroup = _productCategoryForm.productGroups.firstWhereOrNull((element) => element.title.isEmpty);

    if (invalidGroup != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Existem grupos de produtos com o título não preenchido"),
      ));
      return;
    }

    var response = await showLoadingDialog(context, _createDatabase);
    print(response);
  }
}
