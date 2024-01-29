import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_surface_input.dart';
import 'package:ismart/features/onboarding/components/company_category_list_tile.dart';
import 'package:ismart/features/onboarding/providers/onboarding_provider.dart';
import 'package:ismart/features/onboarding/providers/product_category_form.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    OnboardingProvider provider = Provider.of(context);

    return ChangeNotifierProvider.value(
      value: provider.productCategoryForm,
      builder: (context, child) {
        ProductCategoryForm form = Provider.of(context);

        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomScrollView(
                      slivers: [
                        //
                        // Categories title
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: AppSizes.s06,
                              right: AppSizes.s06,
                              bottom: AppSizes.s06,
                            ),
                            child: Text(
                              "Quais os ramos de atuação do seu comércio?",
                              style: textTheme.titleSmall,
                            ),
                          ),
                        ),

                        // Search
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: AppSizes.s06,
                              left: AppSizes.s06,
                              bottom: AppSizes.s03,
                            ),
                            child: LtSurfaceInput(
                              hintText: "Ex.: Mercado",
                            ),
                          ),
                        ),

                        // Groups list
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: AppSizes.s06,
                            right: AppSizes.s06,
                            bottom: AppSizes.s06,
                          ),
                          sliver: SliverGrid.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.2,
                              mainAxisSpacing: AppSizes.s03,
                              crossAxisSpacing: AppSizes.s03,
                            ),
                            itemBuilder: (context, index) {
                              var group = form.availableProductGroups[index];
                              //
                              // Group List tile
                              return CompanyCategoryListTile(
                                selected: form.selectedTemplateGroups.contains(group.id),
                                group: form.availableProductGroups[index],
                                onTap: () => form.toogleSelectedGroup(group.id),
                              );
                            },
                            itemCount: form.availableProductGroups.length,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Gradient
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: AppSizes.s05,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                          colors: [
                            colorScheme.background.withOpacity(0),
                            colorScheme.background.withOpacity(1),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Select current interactions
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.s06,
              ),
              child: LtPrimaryButton(
                label: "Continuar",
                onTap: () => provider.setSelectedGroups(),
              ),
            ),

            const SizedBox(height: AppSizes.s04),
          ],
        );
      },
    );
  }
}
