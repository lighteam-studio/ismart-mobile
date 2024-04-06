import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/models/product_variation_model.dart';

class BasketItemProvider extends ChangeNotifier {
  final ProductVariationModel product;

  late final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: product.unit == ProductUnit.kg ? 2 : 0,
    turnOffGrouping: true,
    symbol: "",
  );
  CurrencyTextInputFormatter get formatter => _formatter;

  late final TextEditingController _lengthController =
      TextEditingController(text: product.unit == ProductUnit.kg ? '1.0' : '1')
        ..addListener(() {
          double value = _formatter.getUnformattedValue().toDouble();

          if (value > product.stock) {
            _lengthController.text = _formatter.formatDouble(product.stock);
          } else if (value < 0) {
            _lengthController.text = _formatter.formatDouble(0);
          }
          notifyListeners();
        });
  TextEditingController get lengthController => _lengthController;

  double get length => double.tryParse(_lengthController.text) ?? 0;
  double get price => length * product.price;

  get canIncrement => length < product.stock;
  get canDecrement => length > 0;

  BasketItemProvider(this.product);

  void increment() {
    if (length < product.stock) {
      var value = _formatter.formatDouble(length + 1);
      _lengthController.text = value;
    }
  }

  void decrement() {
    _lengthController.text =
        length > 1 ? _formatter.formatDouble(length - 1) : '0';
  }

  @override
  void dispose() {
    _lengthController.dispose();
    super.dispose();
  }
}
