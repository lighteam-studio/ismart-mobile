import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/components/lt_progress_bar.dart';
import 'package:ismart/features/onboarding/pages/categories_page.dart';
import 'package:ismart/features/onboarding/pages/groups_page.dart';
import 'package:ismart/features/onboarding/pages/company_name_page.dart';
import 'package:ismart/features/onboarding/providers/onboarding_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/router/app_router.dart';
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
                          ? (provider.pageController.page ?? 0) / 1 //
                          : 0;

                      return Padding(
                        padding: const EdgeInsets.only(
                          left: AppSizes.s03_5,
                          right: AppSizes.s06,
                          bottom: AppSizes.s06,
                        ),
                        child: Row(
                          children: [
                            LtIconButton(
                              onPressed: () => (provider.pageController.page ?? 0) <= 0
                                  ? Navigator.of(context).pushReplacementNamed(AppRouter.welcomePage)
                                  : provider.pageController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    ),
                              icon: AppIcons.arrowLeftCircle,
                              color: colorScheme.onSurface,
                              size: AppSizes.s10,
                            ),
                            const SizedBox(width: AppSizes.s02),
                            Expanded(
                              child: LtProgressBar(
                                progress: position,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: provider.pageController,
                      children: const [
                        CompanyNamePage(),
                        GroupsPage(),
                        CategoriesPage(),
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
