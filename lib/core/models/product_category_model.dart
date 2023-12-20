import 'package:flutter/material.dart';

class ProductCategoryModel extends ChangeNotifier {
  final String id;

  late final TextEditingController _nameController;
  TextEditingController get nameController => _nameController;

  String get name => _nameController.text;

  ProductCategoryModel({required this.id, required String name}) {
    _nameController = TextEditingController(text: name);
  }

  ProductCategoryModel clone() {
    return ProductCategoryModel(
      id: id,
      name: name,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
