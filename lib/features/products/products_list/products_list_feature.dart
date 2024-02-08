import 'package:flutter/material.dart';
import 'package:ismart/components/lt_list_group_title_sliver.dart';
import 'package:ismart/components/lt_search_sliver.dart';
import 'package:ismart/features/products/products_list/components/product_list_tile.dart';
import 'package:ismart/resources/app_sizes.dart';

class ProductsListFeature extends StatelessWidget {
  const ProductsListFeature({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    // ProductListProvider provider = context.read();

    return CustomScrollView(
      slivers: [
        // Search sliver
        LtSearchSliver(
          onFilterClick: () {},
        ),

        // Group title
        const LtListGroupTitleSliver(
          content: "A",
        ),

        // List of products
        SliverList.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            thickness: 1,
            indent: AppSizes.s05,
            endIndent: AppSizes.s05,
            color: colorScheme.surface.withOpacity(.7),
          ),
          itemBuilder: (c, i) => const ProductListTile(),
        ),

        const LtListGroupTitleSliver(
          content: "B",
        ),
        SliverList.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            thickness: 1,
            indent: AppSizes.s05,
            endIndent: AppSizes.s05,
            color: colorScheme.surface.withOpacity(.7),
          ),
          itemBuilder: (c, i) => const ProductListTile(),
        ),

        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.bottom + AppSizes.s10),
        )
      ],
    );
  }
}
