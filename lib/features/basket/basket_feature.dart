import 'package:flutter/material.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/features/basket/components/basket_footer.dart';

class BasketFeature extends StatelessWidget {
  const BasketFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return const LtPage(
      safeAreaBottom: false,
      title: "Basket",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Text("content")),
          BasketFooter(),
        ],
      ),
    );
  }
}
