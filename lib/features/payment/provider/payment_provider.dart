import 'package:flutter/material.dart';
import 'package:ismart/core/entities/transaction_payment_entity.dart';
import 'package:ismart/features/payment/components/payment_method_dialog.dart';

class PaymentProvider extends ChangeNotifier {
  final String transactionId = "123";

  final List<TransactionPaymentEntity> _payments = [];
  List<TransactionPaymentEntity> get payments => _payments;

  void addPayment(BuildContext context) {
    var response = Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentMethodDialog(
          maxValue: 200,
          transactionId: transactionId,
        ),
      ),
    );
  }
}
