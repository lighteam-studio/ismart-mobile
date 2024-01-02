import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_secondary_button.dart';
import 'package:ismart/components/lt_select_form_field.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/components/lt_switch_list_tile.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/features/products/create_product/providers/create_product_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProductFeature extends StatelessWidget {
  const CreateProductFeature({super.key});

  @override
  Widget build(BuildContext context) {
    CreateProductProvider provider = Provider.of(context);
    final s = S.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppSizes.s05),
      children: [
        // Category
        LtSelectFormField<String>(
          label: s.category,
          placeholder: s.placeholderCategory,
          title: s.categories,
          onChange: (value) => provider.selectedCategory = value,
          value: provider.selectedCategory,
          options: const [],
        ),
        const SizedBox(height: AppSizes.s04),

        // USer Name
        LtTextFormField(
          label: s.name,
          placeholder: s.placeholderName,
        ),
        const SizedBox(height: AppSizes.s04),

        // Brand
        LtTextFormField(
          label: s.brand,
          placeholder: s.placeholderBrand,
        ),
        const SizedBox(height: AppSizes.s04),

        // Bar codes
        ...provider.barCodes
            .mapIndexed(
              (i, barCodeController) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.s02),
                child: Row(
                  children: [
                    Expanded(
                      child: LtTextFormField(
                        label: i == 0 ? s.barCode : null,
                        placeholder: s.placeholderBarCode,
                      ),
                    ),
                    if (i > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: AppSizes.s02),
                        child: LtSurfaceButton(
                          icon: AppIcons.times,
                          onTap: () => provider.removeBarCode(i),
                        ),
                      )
                  ],
                ),
              ),
            )
            .toList(),

        // Add new bar code
        LtSecondaryButton(
          label: s.addBarCode,
          onTap: () => provider.addBarCode(),
        ),
        const SizedBox(height: AppSizes.s04),

        // Units
        LtSelectFormField<ProductUnit>(
          label: s.unit,
          title: s.placeholderUnit,
          placeholder: s.placeholderUnit,
          onChange: (value) => provider.unit = value,
          value: provider.unit,
          options: [
            Group(
              title: "",
              items: [
                Option(
                  key: ProductUnit.un,
                  label: s.productUnit(ProductUnit.un.name),
                ),
                Option(
                  key: ProductUnit.kg,
                  label: s.productUnit(ProductUnit.kg.name),
                ),
              ],
            ),
          ],
        ),
        const Divider(thickness: 2, height: AppSizes.s08),

        // Product Has Variations
        LtSwitchListTitle(
          label: s.productHasVariations,
          onChange: (value) => provider.productHasVariations = value,
          selected: provider.productHasVariations,
        ),
        const Divider(thickness: 2, height: AppSizes.s08),

        // Submit button
        LtPrimaryButton(label: s.next, onTap: () {}),
        const SizedBox(height: AppSizes.s08),
      ],
    );
  }
}
