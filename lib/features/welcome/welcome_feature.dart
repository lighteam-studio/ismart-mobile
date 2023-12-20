import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/router/app_router.dart';

class WelcomeFeature extends StatelessWidget {
  const WelcomeFeature({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

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
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.s06_5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    height: AppSizes.s11,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSizes.s10),
                Image.asset(
                  AppImages.illustration1,
                  width: double.infinity,
                ),
                const SizedBox(height: AppSizes.s06),

                // Title
                Text(
                  "Gerencie sua loja de\nforma inteligente",
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSizes.s06),
                Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum",
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(height: AppSizes.s25),
                ),
                LtPrimaryButton(
                  label: "Criar minha loja",
                  onTap: () => Navigator.of(context).pushReplacementNamed(AppRouter.onboardingFeature),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
