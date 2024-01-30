import 'package:flutter/material.dart';
import 'package:ismart/core/enums/preferences.dart';
import 'package:ismart/features/onboarding/providers/company_name_form.dart';
import 'package:ismart/features/onboarding/providers/product_category_form.dart';
import 'package:ismart/repository/abstractions/i_preferences_repository.dart';
import 'package:ismart/router/app_router.dart';

class OnboardingProvider extends ChangeNotifier {
  final IPreferencesRepository _preferencesRepository = IPreferencesRepository.getInstance();

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
  void setSelectedGroups(BuildContext context) async {
    var persisted = await _productCategoryForm.persistSelectedGroups();
    if (!persisted) return;

    try {
      await _preferencesRepository.insert(
        preference: Preference.onboardingFinished,
        value: "true",
      );
      Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.onboardingFinishPage, (route) => false);
    } catch (e) {
      print(e);
    }
  }

  void setSelectedCategories(BuildContext context) async {}
}
