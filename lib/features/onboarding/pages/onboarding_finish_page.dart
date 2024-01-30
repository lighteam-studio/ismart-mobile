import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/router/app_router.dart';

class OnboardingFinishPage extends StatelessWidget {
  const OnboardingFinishPage({super.key});

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
                  AppImages.illustration2,
                  width: 300,
                ),
                const SizedBox(height: AppSizes.s02),

                // Title
                Text(
                  "Parabéns",
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSizes.s06),
                Text(
                  "Agora você pode administrar o seu\ncomércio de forma inteligente",
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                LtPrimaryButton(
                  label: "Ver minha loja",
                  onTap: () => Navigator.of(context).pushReplacementNamed(AppRouter.appShell),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
