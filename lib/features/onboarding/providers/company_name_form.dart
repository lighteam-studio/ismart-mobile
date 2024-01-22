import 'package:flutter/material.dart';

class CompanyNameForm extends ChangeNotifier {
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
}
