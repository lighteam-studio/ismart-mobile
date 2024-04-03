import 'package:flutter/material.dart';
import 'package:ismart/features/basket/components/product_variation_grid_tile.dart';
import 'package:ismart/features/basket/providers/basket_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class BasketSearchPage extends StatelessWidget {
  const BasketSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    BasketProvider basketProvider = Provider.of(context);

    return StreamBuilder(
      stream: basketProvider.productsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Text("No products found");
        }

        var products = snapshot.data!;

        return GridView.builder(
          padding: EdgeInsets.only(
            left: AppSizes.s05,
            right: AppSizes.s05,
            bottom: MediaQuery.of(context).padding.bottom + AppSizes.s05,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSizes.s05,
            crossAxisSpacing: AppSizes.s03,
            childAspectRatio: .64,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];

            return ProductVariationGridTile(
              brand: product.brand,
              image: product.thumbnail != null ? MemoryImage(product.thumbnail!) : null,
              name: product.name,
              onTap: () => basketProvider.addProductToBasket(product),
              price: product.price,
              stock: product.stock,
              unit: product.unit,
              propertyValues: product.variationValues ?? [],
            );
          },
        );
      },
    );
  }
}
