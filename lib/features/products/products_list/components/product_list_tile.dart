import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key});

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
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: const NetworkImage("https://cdn.pixabay.com/photo/2016/11/18/13/47/apple-1834639_640.jpg"),
                ),
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
                      "Maçã fuji",
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
                      "Doce fruta",
                      style: TextStyle(
                        fontSize: AppSizes.s03,
                        color: colorScheme.onSurface.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "R\$ 8,99",
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
                    "45,5 kg",
                    style: TextStyle(
                      fontSize: AppSizes.s03,
                      color: colorScheme.onSurface.withOpacity(.6),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
