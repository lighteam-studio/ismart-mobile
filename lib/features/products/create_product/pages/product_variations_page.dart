import 'package:flutter/material.dart';
import 'package:ismart/components/lt_hollow_button.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/features/products/create_product/components/product_variation_list_tile.dart';
import 'package:ismart/features/products/create_product/providers/create_product_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class ProductVariationsPage extends StatelessWidget {
  const ProductVariationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CreateProductProvider provider = Provider.of(context);
    var textTheme = Theme.of(context).textTheme;

    return ListView(
      controller: provider.scrollController,
      padding: const EdgeInsets.only(
        left: AppSizes.s05,
        right: AppSizes.s05,
        bottom: AppSizes.s05,
      ),
      children: [
        Text(
          "Variations",
          style: textTheme.labelMedium,
        ),
        const SizedBox(height: AppSizes.s02),
        ...provider.variations
            .map(
              (e) => ProductVariationListTile(
                variation: e,
                unit: provider.unit,
                onChange: (variation) => provider.editVariation(context, variation),
              ),
            )
            .toList(),

        const Divider(thickness: 2, height: AppSizes.s08),

        // Submit button
        LtPrimaryButton(
          label: "Cadastrar",
          onTap: () => provider.createProduct(context),
        ),
        const SizedBox(height: AppSizes.s02),

        LtHollowButton(
          label: "Voltar",
          onTap: () => provider.backToFormPage(),
        ),
        const SizedBox(height: AppSizes.s08),
      ],
    );
  }
}
