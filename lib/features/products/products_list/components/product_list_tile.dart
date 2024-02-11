import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductListTile extends StatelessWidget {
  final String name;
  final String brand;
  final ImageProvider? image;

  const ProductListTile({
    required this.name,
    required this.brand,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: AppSizes.s19,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.s05,
          ),
          child: Row(
            children: [
              // Product image
              Container(
                height: AppSizes.s14,
                width: AppSizes.s14,
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
                        placeholder: MemoryImage(kTransparentImage),
                        image: image!,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(width: AppSizes.s02_5),

              // Product Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Product Name
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: AppSizes.s04,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Product brand
                    Text(
                      brand,
                      style: TextStyle(
                        fontSize: AppSizes.s03,
                        color: colorScheme.onSurface.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
