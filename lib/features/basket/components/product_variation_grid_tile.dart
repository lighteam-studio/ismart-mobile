import 'package:flutter/material.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductVariationGridTile extends StatelessWidget {
  final String name;
  final String brand;
  final double price;
  final double stock;
  final ProductUnit unit;
  final ImageProvider? image;
  final List<String> propertyValues;
  final void Function() onTap;

  const ProductVariationGridTile({
    required this.name,
    required this.brand,
    required this.image,
    required this.onTap,
    required this.price,
    required this.unit,
    required this.stock,
    required this.propertyValues,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    String productName() {
      return propertyValues.isEmpty ? name : "$name (${propertyValues.join(' - ')})";
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,

              // Product image
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.s05),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      blurRadius: AppSizes.s03,
                      color: Colors.black.withOpacity(.08),
                    )
                  ],
                ),
                child: image != null
                    ? FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 100),
                        placeholder: MemoryImage(kTransparentImage),
                        image: image!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Image.asset(
                          AppIcons.bag,
                          width: AppSizes.s08,
                          color: colorScheme.onSurface.withOpacity(.1),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppSizes.s01),
            // Product price
            Text(
              "€$price",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: AppSizes.s05,
              ),
            ),
            const SizedBox(height: AppSizes.s00_5),
            // Product name
            Text(
              productName(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.s03_5,
              ),
            ),
            Text(
              brand,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSizes.s03,
                color: colorScheme.onSurface.withOpacity(.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
