import 'package:flutter/material.dart';
import 'package:ismart/components/lt_empty_slider.dart';
import 'package:ismart/components/lt_search_sliver.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/features/products/categories/components/category_list_tile.dart';
import 'package:ismart/features/products/categories/components/group_list_tile.dart';
import 'package:ismart/features/products/categories/components/new_category_list_tile.dart';
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
        List<Widget> renderContent(Group group) {
          return [
            // Group
            GroupListTile(
              onTap: () => provider.upsertGroup(context, groupId: group.id),
              title: group.title,
            ),

            // Categories
            SliverList.separated(
              itemCount: group.items.length,
              separatorBuilder: (context, index) => const Divider(
                indent: AppSizes.s05,
                endIndent: AppSizes.s05,
                height: 1,
              ),
              itemBuilder: (context, index) => CategoryListTile(
                title: group.items[index].name,
                onTap: () => provider.upsertCategory(
                  context,
                  group.id!,
                  category: group.items[index],
                ),
              ),
            ),

            // Add new category
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.s01),
                child: NewCategoryListTile(
                  onTap: () => provider.upsertCategory(context, group.id!),
                ),
              ),
            )
          ];
        }

        return CustomScrollView(
          slivers: [
            // Search sliver
            LtSearchSliver(
              onSearchChange: provider.searchContent,
              action: LtSurfaceButton(
                icon: AppIcons.circlePlus,
                size: AppSizes.s12,
                backgroundColor: colorScheme.onPrimary,
                hasShadow: true,
                onTap: () => provider.upsertGroup(context),
              ),
            ),

            if (provider.search.isNotEmpty && snapshot.data != null && snapshot.data!.isEmpty)
              const LtEmptySliver(text: "No categories found, try another filters"),

            // Content
            ...(snapshot.data ?? [])
                .map(
                  (el) => renderContent(el),
                )
                .expand((el) => el),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom + AppSizes.s10),
            )
          ],
        );
      },
    );
  }
}
