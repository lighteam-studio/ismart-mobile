import 'package:flutter/material.dart';
import 'package:ismart/core/models/product_category_model.dart';

class ProductGroupModel extends ChangeNotifier {
  final String id;
  final String icon;
  final List<ProductCategoryModel> categories;

  late final TextEditingController _titleController;
  TextEditingController get titleController => _titleController;

  String get title => _titleController.text;

  ProductGroupModel({
    required this.id,
    required this.icon,
    required this.categories,
    required String title,
  }) {
    _titleController = TextEditingController(text: title);
  }

  ProductGroupModel clone() {
    return ProductGroupModel(
      id: id,
      title: title,
      icon: icon,
      categories: categories.map((category) => category.clone()).toList(),
    );
  }

  void removeCategory(int index) {
    categories.removeAt(index);
    notifyListeners();
  }

  void addCategory(String title) {
    if (title.isEmpty) return;
    categories.add(ProductCategoryModel(id: title, name: title));
    notifyListeners();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
