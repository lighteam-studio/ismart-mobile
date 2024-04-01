import 'package:ismart/core/enums/transaction_type.dart';

class TransactionEntity {
  String id;
  TransactionType type;
  double amount;
  DateTime date;

  TransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
  });
}
