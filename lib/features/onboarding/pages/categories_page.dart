import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();

    // return ChangeNotifierProvider.value(
    //   value: provider.productCategoryForm,
    //   builder: (context, child) {
    //     ProductCategoryForm form = Provider.of(context);

    //     return Column(
    //       children: [
    //         Expanded(
    //           child: Stack(
    //             children: [
    //               Positioned.fill(
    //                 child: CustomScrollView(
    //                   slivers: [
    //                     //
    //                     // Categories title
    //                     SliverToBoxAdapter(
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(
    //                           left: AppSizes.s06,
    //                           right: AppSizes.s06,
    //                           bottom: AppSizes.s06,
    //                         ),
    //                         child: Text(
    //                           "Defina categorias para seus produtos",
    //                           style: textTheme.titleSmall,
    //                         ),
    //                       ),
    //                     ),

    //                     // Groups list
    //                     SliverPadding(
    //                       padding: const EdgeInsets.only(
    //                         left: AppSizes.s06,
    //                         right: AppSizes.s06,
    //                       ),
    //                       sliver: SliverList.builder(
    //                         itemBuilder: (context, index) {
    //                           var group = form.productGroups[index];

    //                           // Group List tile
    //                           return ChangeNotifierProvider.value(
    //                             value: group,
    //                             child: CategoryGroup(
    //                               deleteGroup: () => form.removeSeletedGroup(group.id),
    //                             ),
    //                           );
    //                         },
    //                         itemCount: form.productGroups.length,
    //                       ),
    //                     ),

    //                     SliverPadding(
    //                       padding: const EdgeInsets.only(
    //                         left: AppSizes.s06,
    //                         right: AppSizes.s06,
    //                         bottom: AppSizes.s06,
    //                       ),
    //                       sliver: SliverToBoxAdapter(
    //                         child: AddGroupInput(
    //                           controller: form.newGroupController,
    //                           onSubmit: () => form.addNewGroup(context),
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),

    //               // Gradient
    //               Align(
    //                 alignment: Alignment.bottomCenter,
    //                 child: Container(
    //                   height: AppSizes.s05,
    //                   decoration: BoxDecoration(
    //                     gradient: LinearGradient(
    //                       begin: Alignment.topCenter,
    //                       end: Alignment.center,
    //                       colors: [
    //                         colorScheme.background.withOpacity(0),
    //                         colorScheme.background.withOpacity(1),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),

    //         // Select current interactions
    //         Padding(
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: AppSizes.s06,
    //           ),
    //           child: LtPrimaryButton(
    //             label: "Finalizar",
    //             onTap: () => provider.setSelectedCategories(context),
    //           ),
    //         ),

    //         const SizedBox(height: AppSizes.s04),
    //       ],
    //     );
    //   },
    // );
  }
}
