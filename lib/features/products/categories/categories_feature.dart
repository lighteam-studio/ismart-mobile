import 'package:flutter/material.dart';
import 'package:ismart/components/lt_search_sliver.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/features/products/categories/components/category_list_tile.dart';
import 'package:ismart/features/products/categories/components/group_list_tile.dart';
import 'package:ismart/features/products/categories/providers/categories_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class CategoriesFeature extends StatelessWidget {
  const CategoriesFeature({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    CategoriesProvider provider = Provider.of(context);

    return StreamBuilder(
      stream: provider.groupsStream,
      builder: (context, snapshot) {
        List<Widget> renderContent(ProductGroupEntity group) {
          return [
            GroupListTile(
              onTap: () {},
              title: group.title,
            ),
            SliverList.separated(
              itemCount: group.categories.length,
              separatorBuilder: (context, index) => const Divider(
                indent: AppSizes.s05,
                endIndent: AppSizes.s05,
                height: 1,
              ),
              itemBuilder: (context, index) => CategoryListTile(
                title: group.categories[index].name,
                onTap: () {},
              ),
            ),
          ];
        }

        return CustomScrollView(
          slivers: [
            // Search sliver
            LtSearchSliver(
              action: LtSurfaceButton(
                icon: AppIcons.circlePlus,
                size: AppSizes.s12,
                backgroundColor: colorScheme.onPrimary,
                hasShadow: true,
                onTap: () {},
              ),
            ),
            ...(snapshot.data ?? []).map((el) => renderContent(el)).expand((el) => el),

            // ...content.expand((e) => e),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom + AppSizes.s10),
            )
          ],
        );
      },
    );
  }
}
