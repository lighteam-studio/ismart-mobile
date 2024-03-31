import 'package:flutter/material.dart';
import 'package:ismart/features/gallery/gallery_feature.dart';
import 'package:ismart/features/gallery/provider/gallery_list_provider.dart';
import 'package:ismart/features/initialization/initialization_feature.dart';
import 'package:ismart/features/initialization/provider/initialization_provider.dart';
import 'package:ismart/features/onboarding/onboarding_feature.dart';
import 'package:ismart/features/onboarding/pages/onboarding_finish_page.dart';
import 'package:ismart/features/products/product_detail/product_detail_feature.dart';
import 'package:ismart/features/products/product_detail/providers/product_detail_provider.dart';
import 'package:ismart/features/store_detail/provider/store_detail_provider.dart';
import 'package:ismart/features/store_detail/store_detail_feature.dart';
import 'package:ismart/features/welcome/welcome_feature.dart';
import 'package:ismart/features/shell/app_shell.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static const String welcomePage = "welcome_page";
  static const String onboardingFeature = "onboarding_feature";
  static const String onboardingFinishPage = "onboarding_finish_page";
  static const String initialization = "initialization_feature";
  static const String appShell = "app_shell";
  static const String productDetail = "product_detail";
  static const String storeDetail = "store_detail";
  static const String gallery = "gallery";

  static Route<dynamic> controller(RouteSettings settings) {
    var args = settings.arguments;

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

      case productDetail:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ProductDetailProvider(args.toString()),
            child: const ProductDetailFeature(),
          ),
        );

      case gallery:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => GalleryListProvider(),
            child: const GalleryFeature(),
          ),
        );

      case storeDetail:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => StoreDetailProvider(),
            child: const StoreDetailFeature(),
          ),
        );

      default:
        throw "Rota inválida";
    }
  }
}
