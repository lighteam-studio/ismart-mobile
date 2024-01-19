import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_secondary_button.dart';
import 'package:ismart/features/products/create_product/components/product_variation_container.dart';
import 'package:ismart/resources/app_sizes.dart';

class ProductVariationsPage extends StatelessWidget {
  const ProductVariationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.s05),
      children: [
        const ProductVariationContainer(),
        const Divider(thickness: 2, height: AppSizes.s08),

        LtSecondaryButton(
          label: "New variation",
          onTap: () {},
        ),
        const SizedBox(height: AppSizes.s03),
        LtSecondaryButton(
          label: "Generate all variations",
          onTap: () {},
        ),

        const Divider(thickness: 2, height: AppSizes.s08),
        // Submit button
        LtPrimaryButton(label: "Cadastrar", onTap: () {}),
        const SizedBox(height: AppSizes.s08),
      ],
    );
  }
}
