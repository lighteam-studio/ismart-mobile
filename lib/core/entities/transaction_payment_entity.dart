import 'package:ismart/core/enums/payment_type.dart';

class TransactionPaymentEntity {
  final PaymentType type;
  final double value;

  TransactionPaymentEntity({
    required this.type,
    required this.value,
  });
}
