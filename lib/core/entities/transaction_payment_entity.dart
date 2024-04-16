import 'package:ismart/core/enums/payment_type.dart';

class TransactionPaymentEntity {
  final String transactionPaymentId;
  final String transactionId;
  final PaymentType type;
  final DateTime date;
  final bool canceled;
  final double value;

  TransactionPaymentEntity({
    required this.transactionPaymentId,
    required this.transactionId,
    required this.type,
    required this.date,
    required this.value,
    required this.canceled,
  });
}
