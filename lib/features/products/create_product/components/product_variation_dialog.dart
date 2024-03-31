import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ismart/components/lt_badge.dart';
import 'package:ismart/components/lt_bottom_sheet_header.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/utils/validators.dart';

class ProductVariationDialog extends StatefulWidget {
  final ProductVariationEntity variation;
  const ProductVariationDialog({required this.variation, super.key});

  @override
  State<ProductVariationDialog> createState() => _ProductVariationDialogState();
}

class _ProductVariationDialogState extends State<ProductVariationDialog> {
  final GlobalKey<FormState> _form = GlobalKey();

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final CurrencyTextInputFormatter _currencyFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: "€ ",
  );

  bool _validateOnInput = false;

  void _submit() {
    setState(() {
      _validateOnInput = true;
    });

    var valid = _form.currentState?.validate() ?? false;
    if (valid) {
      Navigator.of(context).pop(
        ProductVariationEntity(
          sku: "",
          thumbnail: null,
          productId: widget.variation.productId,
          variationId: widget.variation.variationId,
          price: _currencyFormatter.getUnformattedValue().toDouble(),
          stock: double.tryParse(_stockController.text) ?? 0,
          values: widget.variation.values,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height * 0.85;
    var textTheme = Theme.of(context).textTheme;

    List<String> values = widget.variation.values?.map((e) => e.value).toList() ?? [];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSizes.s05),
        ),
      ),
      height: height,
      child: SafeArea(
        child: Column(
          children: [
            //
            // SM Select Header
            const LtBottomSheetHeader(
              title: "Product variation",
            ),

            Expanded(
              child: Form(
                key: _form,
                autovalidateMode: _validateOnInput ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                child: ListView(
                  padding: const EdgeInsets.all(AppSizes.s06),
                  children: [
                    Text("Properties", style: textTheme.labelMedium),
                    const SizedBox(height: AppSizes.s02),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: AppSizes.s02,
                      runSpacing: AppSizes.s02,
                      children: values.map((e) => LtBadge(text: e)).toList(),
                    ),
                    const SizedBox(height: AppSizes.s04),

                    // Name of Property
                    LtTextFormField(
                      label: "Price",
                      mask: _currencyFormatter,
                      placeholder: "Insert the product price",
                      controller: _priceController,
                      validators: [
                        Validators.of(context).required,
                      ],
                    ),
                    const SizedBox(height: AppSizes.s04),

                    // Name of Property
                    LtTextFormField(
                      label: "Stock",
                      mask: FilteringTextInputFormatter.digitsOnly,
                      placeholder: "Insert the initial stock",
                      controller: _stockController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validators: [
                        Validators.of(context).required,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.s06,
                vertical: AppSizes.s03,
              ),
              child: LtPrimaryButton(
                label: "Confirm",
                onTap: _submit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
