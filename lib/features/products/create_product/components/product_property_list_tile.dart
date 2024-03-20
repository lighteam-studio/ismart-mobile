import 'package:flutter/material.dart';
import 'package:ismart/components/lt_surface.dart';
import 'package:ismart/core/entities/product_property_entity.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class ProductPropertyListTile extends StatelessWidget {
  final ProductPropertyEntity property;
  final void Function(ProductPropertyEntity property) onChange;

  const ProductPropertyListTile({
    required this.property,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

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

    return LtSurface(
      padding: EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChange(property),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.s04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(property.name)),
                    Image.asset(
                      AppIcons.popup,
                      color: colorScheme.onSurface,
                      width: AppSizes.s06,
                    )
                  ],
                ),
                const SizedBox(height: AppSizes.s04),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: AppSizes.s02,
                  runSpacing: AppSizes.s02,
                  children: property.propertyValues.map((e) => propertyValue(e)).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
