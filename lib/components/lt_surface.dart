import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSurface extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const LtSurface({
    required this.child,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: AppSizes.s01_5,
            horizontal: AppSizes.s04,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s03),
        color: colorScheme.surface,
      ),
      child: child,
    );
  }
}
