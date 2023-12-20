import 'package:flutter/material.dart';
import 'package:ismart/components/lt_navigation_bar.dart';
import 'package:ismart/resources/app_sizes.dart';

class ShellScaffold extends StatelessWidget {
  final String title;
  final List<LtNavigationMenu> menus;
  final String selectedMenuName;
  final void Function(String routeName) onSelectMenu;
  final Widget child;

  const ShellScaffold({
    required this.title,
    required this.menus,
    required this.onSelectMenu,
    required this.child,
    required this.selectedMenuName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        //
        // Container Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.onPrimary,
              colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //
              // Page title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.s04),
                child: Text(
                  title,
                  style: textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),

              // Navigation bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
                child: LtNavigationBar(
                  onNavigate: onSelectMenu,
                  selectedMenu: selectedMenuName,
                  menus: menus,
                ),
              ),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
