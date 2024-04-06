import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_secondary_button.dart';
import 'package:ismart/components/lt_select_form_field.dart';
import 'package:ismart/components/lt_switch_list_tile.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/features/products/create_product/components/product_barcode_input.dart';
import 'package:ismart/features/products/create_product/components/product_pictures_input.dart';
import 'package:ismart/features/products/create_product/components/product_property_list_tile.dart';
import 'package:ismart/features/products/create_product/providers/create_product_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/utils/validators.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductFormPage extends StatelessWidget {
  final EdgeInsets? padding;

  const ProductFormPage({
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CreateProductProvider provider = Provider.of(context);
    final s = S.of(context);
    final validators = Validators.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Form(
      autovalidateMode: provider.validateOnInput
          ? AutovalidateMode.onUserInteraction //
          : AutovalidateMode.disabled,
      key: provider.productInfoForm,
      child: ListView(
        controller: provider.scrollController,
        padding: padding ??
            const EdgeInsets.only(
              left: AppSizes.s05,
              right: AppSizes.s05,
              bottom: AppSizes.s05,
            ),
        children: [
          // Category
          LtSelectFormField<String>(
            label: s.category,
            placeholder: s.placeholderCategory,
            title: s.categories,
            onChange: (value) => provider.selectedCategory = value ?? '',
            value: provider.selectedCategory,
            options: provider.availableProductGroups,
            validators: [
              validators.required,
            ],
          ),
          const SizedBox(height: AppSizes.s03),

          // Product name
          LtTextFormField(
            label: s.name,
            placeholder: s.placeholderName,
            controller: provider.nameController,
            validators: [
              validators.required,
            ],
          ),
          const SizedBox(height: AppSizes.s03),

          // Brand
          LtTextFormField(
            label: s.brand,
            placeholder: s.placeholderBrand,
            controller: provider.brandController,
            validators: [
              Validators.of(context).required,
            ],
          ),
          const SizedBox(height: AppSizes.s03),

          // Units
          LtSelectFormField<ProductUnit>(
            label: s.unit,
            title: s.placeholderUnit,
            placeholder: s.placeholderUnit,
            onChange: (value) => provider.unit = value ?? ProductUnit.un,
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
            onChange: provider.setProductHasVariations,
            selected: provider.productHasVariations,
          ),

          if (provider.productHasVariations) ...[
            const Divider(thickness: 2, height: AppSizes.s08),

            Text(
              "Properties",
              style: textTheme.labelMedium,
            ),
            const SizedBox(height: AppSizes.s02),
            // Product properties
            ...provider.productProperties.mapIndexed(
              (i, e) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.s02),
                child: ProductPropertyListTile(
                  onChange: (property) => provider.editProperty(context, property),
                  property: e,
                ),
              ),
            ),

            // Add new property
            if (provider.canAddProperty)
              LtSecondaryButton(
                label: "Add new characteristic",
                onTap: () => provider.addProperty(context),
              ),
          ] else ...[
            const Divider(thickness: 2, height: AppSizes.s08),

            // Product images
            ProductPicturesInput(
              pictures: provider.pictures,
              onChange: (p) => provider.pictures = p,
            ),

            const SizedBox(height: AppSizes.s03),

            // Bar codes
            ...provider.barcodes.mapIndexed(
              (i, barCodeController) {
                var barcode = provider.barcodes[i];

                return ProductBarcodeInput(
                  showLabel: i == 0,
                  controller: barcode,
                  canRemove: i > 0,
                  isRequired: provider.barcodes.length > 1,
                  onRemove: () => provider.removeBarCode(i),
                );
              },
            ).toList(),
            // Add new bar code
            LtSecondaryButton(
              label: s.addBarCode,
              onTap: () => provider.addBarCode(),
            ),

            const SizedBox(height: AppSizes.s03),

            // Product price
            LtTextFormField(
              controller: provider.priceController,
              mask: provider.currencyFormatter,
              label: "Product price",
              validators: [
                Validators.of(context).required,
              ],
              placeholder: "Insert your price",
            ),
            const SizedBox(height: AppSizes.s03),

            // Stock controller
            LtTextFormField(
              controller: provider.stockController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              label: "Product stock",
              placeholder: "Insert the stock",
              validators: [
                Validators.of(context).required,
              ],
            ),
          ],

          const Divider(thickness: 2, height: AppSizes.s08),

          // Submit button
          LtPrimaryButton(
            label: provider.productHasVariations ? s.next : "Submit",
            onTap: () => provider.submitProductInfoForm(context),
          ),
          const SizedBox(height: AppSizes.s08),
        ],
      ),
    );
  }
}
