import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class AppNavigationBarItem extends StatelessWidget {
  final bool selected;
  final void Function() onTap;
  final String icon;
  const AppNavigationBarItem({required this.selected, required this.onTap, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.ease,
          height: AppSizes.s12,
          width: AppSizes.s12,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s02_5),
            color: selected ? colorScheme.primary : colorScheme.primary.withOpacity(0),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Image.asset(
                  icon,
                  width: AppSizes.s07,
                  color: selected ? colorScheme.onPrimary : colorScheme.onBackground.withOpacity(.5),
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.ease,
          margin: selected ? const EdgeInsets.only(top: AppSizes.s01_5) : EdgeInsets.zero,
          width: AppSizes.s02,
          height: AppSizes.s02,
          decoration: BoxDecoration(
            color: selected ? colorScheme.primary : colorScheme.primary.withOpacity(0),
            borderRadius: BorderRadius.circular(999),
          ),
        )
      ],
    );
  }
}
