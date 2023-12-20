import 'package:flutter/material.dart';
import 'package:ismart/components/lt_progress_bar.dart';
import 'package:ismart/features/onboarding/pages/balance_page.dart';
import 'package:ismart/features/onboarding/pages/categories_page.dart';
import 'package:ismart/features/onboarding/pages/first_product_page.dart';
import 'package:ismart/features/onboarding/pages/groups_page.dart';
import 'package:ismart/features/onboarding/pages/company_name_page.dart';
import 'package:ismart/features/onboarding/providers/onboarding_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class OnboardingFeature extends StatelessWidget {
  const OnboardingFeature({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
      create: (context) => OnboardingProvider(),
      builder: (context, child) {
        OnboardingProvider provider = Provider.of(context);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.background,
                colorScheme.surface,
              ],
            ),
          ),
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  // Onboarding Progress Bar
                  ListenableBuilder(
                    listenable: provider.pageController,
                    builder: (context, child) {
                      double position = provider.pageController.hasClients
                          ? (provider.pageController.page ?? 0) / 4 //
                          : 0;

                      return Padding(
                        padding: const EdgeInsets.all(AppSizes.s06),
                        child: LtProgressBar(
                          progress: position,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: PageView(
                      controller: provider.pageController,
                      children: const [
                        CompanyNamePage(),
                        GroupsPage(),
                        CategoriesPage(),
                        FirstProductPage(),
                        BalancePage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
