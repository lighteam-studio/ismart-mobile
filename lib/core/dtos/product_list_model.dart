import 'package:flutter/material.dart';

class ProductListModel {
  final String name;
  final String brand;
  final ImageProvider? image;

  ProductListModel({
    required this.name,
    required this.brand,
    this.image,
  });
}
