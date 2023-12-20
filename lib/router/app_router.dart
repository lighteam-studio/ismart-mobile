import 'package:flutter/material.dart';
import 'package:ismart/features/onboarding/onboarding_feature.dart';
import 'package:ismart/features/onboarding/pages/onboarding_finish_page.dart';
import 'package:ismart/features/welcome/welcome_feature.dart';
import 'package:ismart/features/shell/app_shell.dart';

class AppRouter {
  static const String welcomePage = "welcome_page";
  static const String onboardingFeature = "onboarding_feature";
  static const String onboardingFinishPage = "onboarding_finish_page";
  static const String appShell = "app_shell";

  static Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
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
