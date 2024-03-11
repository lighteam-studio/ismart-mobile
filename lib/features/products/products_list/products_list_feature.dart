import 'package:flutter/material.dart';
import 'package:ismart/components/lt_list_group_title_sliver.dart';
import 'package:ismart/components/lt_search_sliver.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/features/products/products_list/components/product_list_tile.dart';
import 'package:ismart/features/products/products_list/providers/product_list_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class ProductsListFeature extends StatelessWidget {
  const ProductsListFeature({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    ProductListProvider provider = context.read();

    return StreamBuilder(
      stream: provider.productsListStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("Nenhum produto cadastrado");
        }

        if (snapshot.hasError) {
          return const Text("Falha ao carregar os produtos");
        }

        List<List<Widget>> content = snapshot.data!
            .map(
              (group) => [
                LtListGroupTitleSliver(
                  content: group.title,
                ),
                SliverList.separated(
                  itemCount: group.items.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    indent: AppSizes.s05,
                    endIndent: AppSizes.s05,
                    color: colorScheme.surface.withOpacity(.7),
                  ),
                  itemBuilder: (c, i) {
                    var product = group.items[i];
                    return ProductListTile(
                      brand: product.brand,
                      name: product.name,
                      image: product.image,
                    );
                  },
                )
              ],
            )
            .toList();

        return CustomScrollView(
          slivers: [
            // Search sliver
            LtSearchSliver(
              action: LtSurfaceButton(
                icon: AppIcons.filter,
                size: AppSizes.s12,
                backgroundColor: colorScheme.onPrimary,
                hasShadow: true,
                onTap: () {},
              ),
            ),
            ...content.expand((e) => e),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom + AppSizes.s10),
            )
          ],
        );
      },
    );
  }
}
