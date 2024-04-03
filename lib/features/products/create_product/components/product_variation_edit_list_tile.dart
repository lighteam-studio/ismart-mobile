import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_surface.dart';
import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class ProductVariationEditListTile extends StatelessWidget {
  final ProductVariationEntity variation;
  final ProductUnit unit;
  final void Function(ProductVariationEntity variation) onChange;

  const ProductVariationEditListTile({
    required this.variation,
    required this.onChange,
    required this.unit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    var values = variation.values?.map((e) => e.value).toList();

    Widget propertyValue(String content) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s04, vertical: AppSizes.s02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.s02_5),
          color: colorScheme.primary,
        ),
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      );
    }

    Widget renderPicturePreview(MediaEntity media) {
      return Container(
        width: AppSizes.s14,
        height: AppSizes.s14,
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(AppSizes.s01),
          image: DecorationImage(
            image: MemoryImage(media.data),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s04),
      child: LtSurface(
        padding: EdgeInsets.zero,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onChange(variation),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.s04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title
                  Row(
                    children: [
                      // Product properties
                      Expanded(
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: AppSizes.s02,
                          runSpacing: AppSizes.s02,
                          children: values?.map((e) => propertyValue(e)).toList() ?? [],
                        ),
                      ),
                      Image.asset(
                        AppIcons.popup,
                        color: colorScheme.onSurface,
                        width: AppSizes.s06,
                      )
                    ],
                  ),
                  const SizedBox(height: AppSizes.s02),

                  // Product SKU
                  Text(
                    variation.sku,
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withOpacity(.5)),
                  ),
                  Divider(
                    color: colorScheme.onSurface.withOpacity(.1),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Price",
                              style: textTheme.labelSmall,
                            ),
                            Text(
                              CurrencyTextInputFormatter(decimalDigits: 2, symbol: "€").formatDouble((variation.price)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Stock",
                              style: textTheme.labelSmall,
                            ),
                            Text("${variation.stock} ${unit.name}")
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Barcodes
                  if (variation.barcodes != null) ...[
                    Divider(
                      color: colorScheme.onSurface.withOpacity(.1),
                    ),
                    Text(
                      "Barcodes",
                      style: textTheme.labelSmall,
                    ),
                    Text(variation.barcodes!.map((e) => e.value).join(' | '))
                  ],

                  // Images
                  if (variation.images != null && variation.images!.isNotEmpty) ...[
                    Divider(color: colorScheme.onSurface.withOpacity(.1)),
                    Wrap(
                      spacing: AppSizes.s01_5,
                      runSpacing: AppSizes.s01_5,
                      children: variation.images!
                          .map(
                            (e) => renderPicturePreview(e.image!),
                          )
                          .toList(),
                    )
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
