import 'package:flutter/material.dart';
import 'package:ismart/features/initialization/initialization_feature.dart';
import 'package:ismart/features/initialization/provider/initialization_provider.dart';
import 'package:ismart/features/onboarding/onboarding_feature.dart';
import 'package:ismart/features/onboarding/pages/onboarding_finish_page.dart';
import 'package:ismart/features/welcome/welcome_feature.dart';
import 'package:ismart/features/shell/app_shell.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static const String welcomePage = "welcome_page";
  static const String onboardingFeature = "onboarding_feature";
  static const String onboardingFinishPage = "onboarding_finish_page";
  static const String initialization = "initialization_feature";
  static const String appShell = "app_shell";

  static Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case initialization:
        return MaterialPageRoute(
          builder: (contect) => ChangeNotifierProvider(
            create: (context) => InitializationProvider(),
            child: const InitializationFeature(),
          ),
        );

      case welcomePage:
        return MaterialPageRoute(builder: (contect) => const WelcomeFeature());

      case onboardingFeature:
        return MaterialPageRoute(builder: (contect) => const OnboardingFeature());

      case onboardingFinishPage:
        return MaterialPageRoute(builder: (contect) => const OnboardingFinishPage());

      case appShell:
        return MaterialPageRoute(builder: (contect) => const AppShell());

      default:
        throw "Rota inválida";
    }
  }
}
