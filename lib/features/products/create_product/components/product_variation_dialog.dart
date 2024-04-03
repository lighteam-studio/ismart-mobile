import 'package:collection/collection.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ismart/components/lt_badge.dart';
import 'package:ismart/components/lt_bottom_sheet_header.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_secondary_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/features/products/create_product/components/product_barcode_input.dart';
import 'package:ismart/features/products/create_product/components/product_pictures_input.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class ProductVariationDialog extends StatefulWidget {
  final ProductVariationEntity variation;
  final ProductUnit unit;
  const ProductVariationDialog({required this.variation, required this.unit, super.key});

  @override
  State<ProductVariationDialog> createState() => _ProductVariationDialogState();
}

class _ProductVariationDialogState extends State<ProductVariationDialog> {
  final GlobalKey<FormState> _form = GlobalKey();
  final CurrencyTextInputFormatter _currencyFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    symbol: "€ ",
  );

  late final TextEditingController _priceController;
  late final TextEditingController _stockController;

  late List<MediaEntity> _pictures;
  late List<TextEditingController> _barcodes;

  bool _validateOnInput = false;

  void _submit() {
    setState(() {
      _validateOnInput = true;
    });

    var valid = _form.currentState?.validate() ?? false;
    if (valid) {
      const uuid = Uuid();

      Navigator.of(context).pop(
        ProductVariationEntity(
          sku: widget.variation.sku,
          thumbnail: _pictures.isNotEmpty ? _pictures.first.mediaId : null,
          productId: widget.variation.productId,
          variationId: widget.variation.variationId,
          price: _currencyFormatter.getUnformattedValue().toDouble(),
          stock: double.tryParse(_stockController.text) ?? 0,
          values: widget.variation.values,
          barcodes: _barcodes
              .map(
                (e) => ProductBarcodeEntity(
                  productBarcodeId: uuid.v4(),
                  productVariationId: widget.variation.variationId,
                  value: e.text,
                ),
              )
              .toList(),
          images: _pictures
              .map(
                (e) => ProductImageEntity(
                  productImageId: uuid.v4(),
                  imageId: e.mediaId,
                  variationId: widget.variation.variationId,
                  image: e,
                ),
              )
              .toList(),
        ),
      );
    }
  }

  @override
  void initState() {
    var images = widget.variation.images?.map((e) => e.image!).toList();
    var stock = widget.variation.stock;

    _priceController = TextEditingController(text: _currencyFormatter.formatDouble(widget.variation.price));
    _stockController = TextEditingController(
      text: widget.unit == ProductUnit.un ? stock.toInt().toString() : stock.toString(),
    );
    _pictures = images ?? [];
    _barcodes = widget.variation.barcodes?.map((e) => TextEditingController(text: e.value)).toList() ??
        [TextEditingController()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
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

                    // Product images
                    Text("Images", style: textTheme.labelMedium),
                    const SizedBox(height: AppSizes.s02),
                    ProductPicturesInput(
                      pictures: _pictures,
                      onChange: (p) => setState(() => _pictures = p),
                    ),

                    const SizedBox(height: AppSizes.s03),

                    // Bar codes
                    ..._barcodes.mapIndexed(
                      (i, barCodeController) {
                        var barcode = _barcodes[i];

                        return ProductBarcodeInput(
                          showLabel: i == 0,
                          controller: barcode,
                          canRemove: i > 0,
                          onRemove: () => setState(() => _barcodes.removeAt(i)),
                        );
                      },
                    ).toList(),
                    // Add new bar code
                    LtSecondaryButton(
                      label: s.addBarCode,
                      onTap: () => setState(() => _barcodes.add(TextEditingController())),
                    ),

                    const SizedBox(height: AppSizes.s03),

                    // Price of Property
                    LtTextFormField(
                      label: "Price",
                      mask: _currencyFormatter,
                      placeholder: "Insert the product price",
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validators: [
                        Validators.of(context).required,
                      ],
                    ),
                    const SizedBox(height: AppSizes.s04),

                    // Stock of Property
                    LtTextFormField(
                      label: "Stock",
                      mask: FilteringTextInputFormatter.digitsOnly,
                      placeholder: "Insert the initial stock",
                      controller: _stockController,
                      keyboardType: TextInputType.numberWithOptions(decimal: widget.unit == ProductUnit.kg),
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
