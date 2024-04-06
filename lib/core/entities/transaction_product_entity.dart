import 'dart:typed_data';

import 'package:ismart/core/enums/product_unit.dart';

class TransactionProductEntity {
  final String name;
  final Uint8List? thumbnail;
  final String brand;
  final ProductUnit unit;
  final double unitPrice;
  final double amount;

  TransactionProductEntity({
    required this.name,
    required this.thumbnail,
    required this.brand,
    required this.unit,
    required this.unitPrice,
    required this.amount,
  });
}
