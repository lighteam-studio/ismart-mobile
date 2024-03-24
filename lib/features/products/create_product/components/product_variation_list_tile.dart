import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_surface.dart';
import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class ProductVariationListTile extends StatelessWidget {
  final ProductVariationEntity variation;
  final ProductUnit unit;
  final void Function(ProductVariationEntity variation) onChange;

  const ProductVariationListTile({
    required this.variation,
    required this.onChange,
    required this.unit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

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
                  Row(
                    children: [
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
                  const SizedBox(height: AppSizes.s04),
                  Text(
                    "Price: ${CurrencyTextInputFormatter(decimalDigits: 2, symbol: "€").formatDouble((variation.price))}",
                  ),
                  Divider(
                    color: colorScheme.onSurface.withOpacity(.1),
                  ),
                  Text("Stock: ${variation.stock} ${unit.name}")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
