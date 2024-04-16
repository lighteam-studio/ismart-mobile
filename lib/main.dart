import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:ismart/repository/abstractions/media_repository.dart';
import 'package:ismart/repository/abstractions/preferences_repository.dart';
import 'package:ismart/repository/abstractions/product_category_repository.dart';
import 'package:ismart/repository/abstractions/product_group_repository.dart';
import 'package:ismart/repository/abstractions/product_variation_repository.dart';
import 'package:ismart/repository/abstractions/products_repository.dart';
import 'package:ismart/repository/local/media_local_repository.dart';
import 'package:ismart/repository/local/preferences_local_repository.dart';
import 'package:ismart/repository/local/product_category_local_repository.dart';
import 'package:ismart/repository/local/product_group_local_repository.dart';
import 'package:ismart/repository/local/product_variation_local_repository.dart';
import 'package:ismart/repository/local/products_local_repository.dart';
import 'package:ismart/resources/app_colors.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/router/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  GetIt.instance.registerLazySingleton<PreferencesRepository>(() => PreferencesLocalRepository());
  GetIt.instance.registerLazySingleton<ProductGroupRepository>(() => ProductGroupLocalRepository());
  GetIt.instance.registerLazySingleton<ProductsRepository>(() => ProductsLocalRepository());
  GetIt.instance.registerLazySingleton<ProductCategoryRepository>(() => ProductCategoryLocalRepository());
  GetIt.instance.registerLazySingleton<MediaRepository>(() => MediaLocalRepository());
  GetIt.instance.registerLazySingleton<ProductVariationRepository>(() => ProductVariationLocalRepository());

  sqfliteFfiInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    // App Color Scheme
    var colorScheme = ColorScheme.light(
      background: AppColors.neutral.shade100,
      primary: AppColors.primary.shade500,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary.shade600,
      onBackground: AppColors.neutral.shade400,
      surface: AppColors.neutral.shade200,
      surfaceVariant: Colors.white,
      onSurfaceVariant: AppColors.neutral.shade500,
      onSurface: AppColors.neutral.shade500,
      errorContainer: Colors.red.shade100,
      error: Colors.red.shade400,
      tertiary: Colors.green,
    );

    var textTheme = TextTheme(
      displaySmall: TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontSize: AppSizes.s05,
        letterSpacing: 0,
        height: 1.15,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontSize: AppSizes.s06,
        letterSpacing: 0,
        height: 1.15,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Ubuntu',
        color: colorScheme.onSurface,
        fontSize: AppSizes.s05,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.25,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Ubuntu",
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontSize: AppSizes.s04,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Ubuntu",
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
        fontSize: AppSizes.s04,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w400,
        color: colorScheme.onBackground,
        fontSize: AppSizes.s03_5,
        letterSpacing: 0,
        height: 1.3,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        fontSize: AppSizes.s03_5,
        letterSpacing: 0,
        height: 1.3,
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        title: 'isMart',
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          colorScheme: colorScheme,
          textTheme: textTheme,
          useMaterial3: true,
          dividerTheme: DividerThemeData(
            thickness: 1,
            space: 1,
            indent: AppSizes.s05,
            endIndent: AppSizes.s05,
            color: colorScheme.surface.withOpacity(.7),
          ),
        ),
        supportedLocales: S.supportedLocales,
        localizationsDelegates: S.localizationsDelegates,
        initialRoute: AppRouter.initialization,
        onGenerateRoute: AppRouter.controller,
      ),
    );
  }
}
