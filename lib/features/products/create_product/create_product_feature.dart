import 'package:flutter/material.dart';
import 'package:ismart/features/products/create_product/pages/product_form_page.dart';
import 'package:ismart/features/products/create_product/pages/product_variations_page.dart';

class CreateProductFeature extends StatelessWidget {
  const CreateProductFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        ProductFormPage(),
        ProductVariationsPage(),
      ],
    );
  }
}
