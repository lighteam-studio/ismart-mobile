import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/models/product_variation_model.dart';

class BasketItemProvider extends ChangeNotifier {
  final ProductVariationModel product;

  late final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: product.unit == ProductUnit.kg ? 2 : 0,
    symbol: "",
  );

  late final TextEditingController _lengthController = TextEditingController(text: "1")
    ..addListener(() {
      notifyListeners();
    });
  TextEditingController get lengthController => _lengthController;

  double get length => double.tryParse(_lengthController.text) ?? 1;
  double get price => length * product.price;

  get canIncrement => length < product.stock;
  get canDecrement => length > 1;

  BasketItemProvider(this.product);

  void increment() {
    if (length < product.stock) {
      _lengthController.text = _formatter.formatDouble(length + 1);
      notifyListeners();
    }
  }

  void decrement() {
    if (length > 1) {
      _lengthController.text = _formatter.formatDouble(length - 1);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _lengthController.dispose();
    super.dispose();
  }
}
