import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ismart/core/entities/transaction_payment_entity.dart';
import 'package:ismart/core/enums/payment_type.dart';
import 'package:uuid/uuid.dart';

class PaymentMethodProvider extends ChangeNotifier {
  late final double _maxValue;
  late final String _transactionId;

  final CurrencyTextInputFormatter _currencyFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: "€ ",
  );
  CurrencyTextInputFormatter get currencyFormatter => _currencyFormatter;

  late final TextEditingController _valueController = TextEditingController()
    ..addListener(() {
      var parsedValue = _currencyFormatter.getUnformattedValue().toDouble();
      if (parsedValue > _maxValue) {
        insertTotalValue();
      }
    });
  TextEditingController get valueController => _valueController;

  double get paymentValue => _currencyFormatter.getUnformattedValue().toDouble();

  PaymentType? _paymentType;
  PaymentType? get paymentType => _paymentType;
  set paymentType(PaymentType? type) {
    _paymentType = type;
    notifyListeners();
  }

  PaymentMethodProvider({required double maxValue, required String transactionId}) {
    _maxValue = maxValue;
    _transactionId = transactionId;
  }

  void insertTotalValue() {
    _valueController.text = _currencyFormatter.formatDouble(_maxValue);
  }

  void submitPayment(BuildContext context) {
    if (paymentType == null || paymentValue == 0) return;

    var payment = TransactionPaymentEntity(
      transactionPaymentId: const Uuid().v4(),
      transactionId: _transactionId,
      date: DateTime.now(),
      type: _paymentType!,
      value: _currencyFormatter.getUnformattedValue().toDouble(),
      canceled: false,
    );

    // TODO, insert payment
    Navigator.of(context).pop(payment);
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }
}
