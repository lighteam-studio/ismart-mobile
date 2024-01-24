import 'package:flutter/material.dart';
import 'package:ismart/features/shell/components/app_navigation_bar_item.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class AppNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onNavigate;
  const AppNavigationBar({required this.selectedIndex, required this.onNavigate, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSizes.s06_5)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.05),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.s03),
          child: SizedBox(
            height: 62,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppNavigationBarItem(
                  selected: selectedIndex == 0,
                  onTap: () => onNavigate(0),
                  icon: AppIcons.bag,
                ),
                AppNavigationBarItem(
                  selected: selectedIndex == 1,
                  onTap: () => onNavigate(1),
                  icon: AppIcons.products,
                ),
                AppNavigationBarItem(
                  selected: selectedIndex == 2,
                  onTap: () => onNavigate(2),
                  icon: AppIcons.basket,
                ),
                AppNavigationBarItem(
                  selected: selectedIndex == 3,
                  onTap: () => onNavigate(3),
                  icon: AppIcons.paintBrush,
                ),
                AppNavigationBarItem(
                  selected: selectedIndex == 4,
                  onTap: () => onNavigate(4),
                  icon: AppIcons.shop,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
