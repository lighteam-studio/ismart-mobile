import 'package:flutter/material.dart';
import 'package:ismart/features/delivery/delivery_feature.dart';
import 'package:ismart/features/products/products_shell.dart';
import 'package:ismart/features/shell/components/app_navigation_bar.dart';
import 'package:ismart/features/shell/components/app_shell_animated_switcher.dart';
import 'package:ismart/features/store/store_feature.dart';
import 'package:ismart/features/transactions/transactions_feature.dart';
import 'package:ismart/resources/app_sizes.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedPage = 0;
  int direction = -1;

  Widget renderContent() {
    if (selectedPage == 0) {
      return const TransactionsFeature();
    }

    if (selectedPage == 1) {
      return const ProductsShell();
    }

    if (selectedPage == 3) {
      return const DeliveryFeature();
    }

    if (selectedPage == 4) {
      return const StoreFeature();
    }

    return const SizedBox.shrink();
  }

  void onNavigate(int index) {
    if (index == 2) {
      return;
    }

    setState(() {
      direction = index > selectedPage ? 1 : -1;
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
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
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.s15),
                child: AppShellAnimatedSwitcher(
                  direction: direction,
                  child: renderContent(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AppNavigationBar(
                selectedIndex: selectedPage,
                onNavigate: onNavigate,
              ),
            )
          ],
        ),
      ),
    );
  }
}
