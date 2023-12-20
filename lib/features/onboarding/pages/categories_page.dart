import 'package:flutter/material.dart';
import 'package:ismart/components/lt_hollow_button.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/features/onboarding/components/category_group.dart';
import 'package:ismart/features/onboarding/providers/onboarding_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    OnboardingProvider provider = Provider.of(context);

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
                          "Defina categorias para seus produtos",
                          style: textTheme.titleSmall,
                        ),
                      ),
                    ),

                    if (provider.selectedGroups.isEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(AppSizes.s04),
                          child: Text(
                            "Nenhum grupo de produtos adicionado",
                            textAlign: TextAlign.center,
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
                      sliver: SliverList.builder(
                        itemBuilder: (context, index) {
                          var group = provider.selectedGroups[index];
                          // Group List tile
                          return ChangeNotifierProvider.value(
                            value: group,
                            child: CategoryGroup(
                              deleteGroup: () => provider.removeSeletedGroup(group.id),
                            ),
                          );
                        },
                        itemCount: provider.selectedGroups.length,
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
            onTap: () {},
          ),
        ),

        // Skip this step
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s06),
          child: LtHollowButton(
            label: "Pular",
            onTap: () {},
          ),
        ),
        const SizedBox(height: AppSizes.s04),
      ],
    );
  }
}
