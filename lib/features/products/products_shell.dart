import 'package:flutter/material.dart';
import 'package:ismart/components/lt_navigation_bar.dart';
import 'package:ismart/features/products/categories/categories_feature.dart';
import 'package:ismart/features/products/create_product/create_product_feature.dart';
import 'package:ismart/features/products/products_dashboard/products_dashboard_feature.dart';
import 'package:ismart/features/products/products_list/products_list_feature.dart';
import 'package:ismart/features/shell/components/shell_scaffold.dart';
import 'package:ismart/resources/app_icons.dart';

class ProductsShell extends StatefulWidget {
  const ProductsShell({super.key});

  @override
  State<ProductsShell> createState() => _ProductsShellState();
}

class _ProductsShellState extends State<ProductsShell> {
  var selectedPage = "dashboard";

  Widget renderPage() {
    if (selectedPage == "dashboard") {
      return const ProductsDashboardFeature();
    }
    if (selectedPage == "produtos") {
      return const ProductsListFeature();
    }
    if (selectedPage == "new_product") {
      return const CreateProductFeature();
    }
    if (selectedPage == "categories") {
      return const CategoriesFeature();
    }

    return const Text("Invalid route");
  }

  @override
  Widget build(BuildContext context) {
    return ShellScaffold(
      title: "Products",
      selectedMenuName: selectedPage,
      onSelectMenu: (menu) => setState(() => selectedPage = menu),
      menus: [
        //
        // Products router
        LtNavigationMenu(
          icon: AppIcons.dashboard,
          label: "Dashboard",
          routeName: "dashboard",
        ),

        // Products router
        LtNavigationMenu(
          icon: AppIcons.queue,
          label: "Produtos",
          routeName: "produtos",
        ),

        // Products router
        LtNavigationMenu(
          icon: AppIcons.create,
          label: "Cadastrar produto",
          routeName: "new_product",
        ),

        // Products router
        LtNavigationMenu(
          icon: AppIcons.categories,
          label: "Categorias",
          routeName: "categories",
        ),
      ],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease,
        child: renderPage(),
      ),
    );
  }
}
