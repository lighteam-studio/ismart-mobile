import 'package:flutter/material.dart';
import 'package:ismart/components/lt_navigation_bar.dart';
import 'package:ismart/features/products/categories/categories_feature.dart';
import 'package:ismart/features/products/categories/providers/categories_provider.dart';
import 'package:ismart/features/products/create_product/create_product_feature.dart';
import 'package:ismart/features/products/create_product/providers/create_product_provider.dart';
import 'package:ismart/features/products/products_dashboard/products_dashboard_feature.dart';
import 'package:ismart/features/products/products_list/products_list_feature.dart';
import 'package:ismart/features/products/products_list/providers/product_list_provider.dart';
import 'package:ismart/features/shell/components/shell_scaffold.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsShell extends StatefulWidget {
  const ProductsShell({super.key});

  @override
  State<ProductsShell> createState() => _ProductsShellState();
}

class _ProductsShellState extends State<ProductsShell> {
  var selectedPage = "produtos";

  Widget renderPage() {
    if (selectedPage == "dashboard") {
      return const ProductsDashboardFeature(
        key: ValueKey("dashboard"),
      );
    }
    if (selectedPage == "produtos") {
      return const ProductsListFeature(
        key: ValueKey("products"),
      );
    }
    if (selectedPage == "new-product") {
      return const CreateProductFeature(
        key: ValueKey("new-product"),
      );
    }
    if (selectedPage == "categories") {
      return const CategoriesFeature(
        key: ValueKey("categories"),
      );
    }

    return const Text("Invalid route");
  }

  @override
  Widget build(BuildContext context) {
    return ShellScaffold(
      title: S.of(context).products,
      selectedMenuName: selectedPage,
      onSelectMenu: (menu) => setState(() => selectedPage = menu),
      menus: [
        // Products router
        LtNavigationMenu(
          icon: AppIcons.queue,
          label: S.of(context).products,
          routeName: "produtos",
        ),

        // Products router
        LtNavigationMenu(
          icon: AppIcons.create,
          label: S.of(context).createProduct,
          routeName: "new-product",
        ),

        // Products router
        LtNavigationMenu(
          icon: AppIcons.categories,
          label: S.of(context).categories,
          routeName: "categories",
        ),
      ],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: const Interval(.6, 1, curve: Curves.ease),
        switchOutCurve: const Interval(.6, 1, curve: Curves.ease),
        child: MultiProvider(
          //
          // Providers
          providers: [
            ChangeNotifierProvider(create: (context) => CreateProductProvider(context)),
            ChangeNotifierProvider(create: (context) => ProductListProvider()),
            ChangeNotifierProvider(create: (context) => CategoriesProvider()),
          ],
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            switchInCurve: const Interval(.6, 1, curve: Curves.ease),
            switchOutCurve: const Interval(.6, 1, curve: Curves.ease),
            child: renderPage(),
          ),
        ),
      ),
    );
  }
}
