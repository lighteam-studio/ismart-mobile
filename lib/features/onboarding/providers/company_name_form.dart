import 'package:flutter/material.dart';
import 'package:ismart/core/enums/preferences.dart';
import 'package:ismart/repository/abstractions/i_preferences_repository.dart';

class CompanyNameForm extends ChangeNotifier {
  final IPreferencesRepository _preferencesRepository = IPreferencesRepository.getInstance();

  bool _loading = false;

  /// Validate form on input
  bool _validateOnInput = false;
  bool get validateOnInput => _validateOnInput;
  set validateOnInput(bool value) {
    _validateOnInput = value;
    notifyListeners();
  }

  /// Company Name
  final GlobalKey<FormState> _shopNameForm = GlobalKey();
  GlobalKey<FormState> get shopNameForm => _shopNameForm;

  /// Company name controller
  final TextEditingController _shopNameController = TextEditingController();
  TextEditingController get shopNameController => _shopNameController;

  CompanyNameForm() {
    _initialize();
  }

  void _initialize() async {
    try {
      _shopNameController.text = await _preferencesRepository.getPreference(Preference.shopName);
    } catch (e) {
      return;
    }
  }

  Future<bool> updateCompanyName() async {
    validateOnInput = true;
    var isValid = shopNameForm.currentState?.validate() ?? false;
    if (!isValid || _loading) return false;

    try {
      _loading = true;

      await _preferencesRepository.insert(
        preference: Preference.shopName,
        value: _shopNameController.text,
      );
      return true;
    } catch (e) {
      return false;
    } finally {
      _loading = false;
    }
  }
}
