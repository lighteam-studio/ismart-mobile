import 'package:ismart/core/enums/transaction_type.dart';

class TransactionEntity {
  String transactionId;
  TransactionType type;
  DateTime date;

  TransactionEntity({
    required this.transactionId,
    required this.type,
    required this.date,
  });
}
