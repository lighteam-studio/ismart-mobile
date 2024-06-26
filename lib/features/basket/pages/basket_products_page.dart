import 'package:flutter/material.dart';
import 'package:ismart/features/basket/components/basket_footer.dart';
import 'package:ismart/features/basket/components/basket_list_tile.dart';
import 'package:ismart/features/basket/providers/basket_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class BasketProductsPage extends StatelessWidget {
  const BasketProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    BasketProvider basketProvider = Provider.of(context);

    return Column(
      children: [
        Expanded(
          child: basketProvider.basketItems.isNotEmpty
              ? ListView.separated(
                  itemCount: basketProvider.basketItems.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSizes.s03),
                  itemBuilder: (context, index) {
                    var basketItem = basketProvider.basketItems[index];

                    return BasketListTile(
                      onRemove: () {
                        basketProvider.removeProductFrombasket(index);
                      },
                      amount: basketItem.amount,
                      brand: basketItem.brand,
                      name: basketItem.name,
                      onChangeAmount: (value) => basketProvider.changeAmount(index, value),
                      stock: basketItem.stock,
                      unit: basketItem.unit,
                      unitPrice: basketItem.price,
                      thumbnail: basketItem.thumbnail != null ? MemoryImage(basketItem.thumbnail!) : null,
                    );
                  },
                )
              : const Center(
                  child: Text("You don't have products in basket"),
                ),
        ),
        const BasketFooter(),
      ],
    );
  }
}
