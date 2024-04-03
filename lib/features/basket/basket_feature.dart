import 'package:flutter/material.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/features/basket/components/basket_search_input.dart';
import 'package:ismart/features/basket/pages/basket_products_page.dart';
import 'package:ismart/features/basket/pages/basket_search_page.dart';
import 'package:ismart/features/basket/providers/basket_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class BasketFeature extends StatelessWidget {
  const BasketFeature({super.key});

  @override
  Widget build(BuildContext context) {
    BasketProvider provider = Provider.of(context);

    return LtPage(
      safeAreaBottom: false,
      title: "Basket",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s05,
              vertical: AppSizes.s03,
            ),
            child: BasketSearchInput(controller: provider.searchController),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: provider.searchController,
              builder: (context, child) {
                return AnimatedSwitcher(
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: .98, end: 1).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  duration: const Duration(milliseconds: 300),
                  child: provider.searchController.text.isNotEmpty
                      ? const BasketSearchPage() //
                      : const BasketProductsPage(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
