import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_file_picker.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_secondary_button.dart';
import 'package:ismart/components/lt_select_form_field.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/components/lt_switch_list_tile.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/features/products/create_product/components/product_property_container.dart';
import 'package:ismart/features/products/create_product/providers/create_product_provider.dart';
import 'package:ismart/resources/app_icons.dart';
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

    return Form(
      autovalidateMode: provider.validateOnInput
          ? AutovalidateMode.onUserInteraction //
          : AutovalidateMode.disabled,
      key: provider.productInfoForm,
      child: ListView(
        padding: padding ?? const EdgeInsets.all(AppSizes.s05),
        children: [
          LtFilePicker(
            onChange: (pictures) => provider.addPictures(pictures),
            pictures: provider.pictures,
            onRemovePicture: provider.removePicture,
          ),
          const SizedBox(height: AppSizes.s03),

          // Category
          LtSelectFormField<String>(
            label: s.category,
            placeholder: s.placeholderCategory,
            title: s.categories,
            onChange: (value) => provider.category = value ?? '',
            value: provider.category,
            options: provider.availableProductGroups,
            validators: [
              validators.required,
            ],
          ),
          const SizedBox(height: AppSizes.s03),

          // User Name
          LtTextFormField(
            label: s.name,
            placeholder: s.placeholderName,
            initialValue: provider.name,
            onChanged: (value) => provider.name = value,
            validators: [
              validators.required,
            ],
          ),
          const SizedBox(height: AppSizes.s03),

          // Brand
          LtTextFormField(
            label: s.brand,
            placeholder: s.placeholderBrand,
            initialValue: provider.brand,
            onChanged: (value) => provider.brand = value,
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
          const SizedBox(height: AppSizes.s03),

          // Bar codes
          ...provider.barcodes.mapIndexed(
            (i, barCodeController) {
              var barcode = provider.barcodes[i];

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.s03),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LtTextFormField(
                        label: i == 0 ? s.barCode : null,
                        placeholder: s.placeholderBarCode,
                        initialValue: barcode.value,
                        onChanged: (value) => provider.editBarcode(i, value),
                        validators: [
                          Validators.of(context).required,
                        ],
                      ),
                    ),
                    if (i > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: AppSizes.s03),
                        child: LtSurfaceButton(
                          icon: AppIcons.times,
                          onTap: () => provider.removeBarCode(i),
                        ),
                      )
                  ],
                ),
              );
            },
          ).toList(),

          // Add new bar code
          LtSecondaryButton(
            label: s.addBarCode,
            onTap: () => provider.addBarCode(),
          ),

          const Divider(thickness: 2, height: AppSizes.s08),

          // Product Has Variations
          LtSwitchListTitle(
            label: s.productHasVariations,
            onChange: (value) => provider.productHasVariations = value,
            selected: provider.productHasVariations,
          ),
          if (provider.productHasVariations) ...[
            const Divider(thickness: 2, height: AppSizes.s08),
            // Variations
            const ProductPropertyContainer(),

            LtSecondaryButton(
              label: "Add new characteristic",
              onTap: () => provider.addBarCode(),
            ),
          ],

          const Divider(thickness: 2, height: AppSizes.s08),

          // Submit button
          LtPrimaryButton(label: s.next, onTap: () => provider.submitProductInfoForm()),
          const SizedBox(height: AppSizes.s08),
        ],
      ),
    );
  }
}
