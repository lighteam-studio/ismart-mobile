import 'package:flutter/material.dart';
import 'package:ismart/components/lt_navigation_bar.dart';
import 'package:ismart/features/shell/components/shell_scaffold.dart';
import 'package:ismart/features/transactions/transactions_list/transactions_list_feature.dart';
import 'package:ismart/resources/app_icons.dart';

class TransactionsShell extends StatefulWidget {
  const TransactionsShell({super.key});

  @override
  State<TransactionsShell> createState() => _TransactionsShellState();
}

class _TransactionsShellState extends State<TransactionsShell> {
  var selectedPage = "list";

  Widget renderPage() {
    if (selectedPage == "list") {
      return const TransactionsListFeature(
        key: ValueKey("dashboard"),
      );
    }

    return const Text("Invalid route");
  }

  @override
  Widget build(BuildContext context) {
    return ShellScaffold(
      title: "Transactions",
      selectedMenuName: selectedPage,
      onSelectMenu: (menu) => setState(() => selectedPage = menu),
      menus: [
        // Products router
        LtNavigationMenu(
          icon: AppIcons.queue,
          label: "Transactions",
          routeName: "list",
        ),
      ],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: const Interval(.6, 1, curve: Curves.ease),
        switchOutCurve: const Interval(.6, 1, curve: Curves.ease),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          switchInCurve: const Interval(.6, 1, curve: Curves.ease),
          switchOutCurve: const Interval(.6, 1, curve: Curves.ease),
          child: renderPage(),
        ),
      ),
    );
  }
}
