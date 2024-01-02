import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSurfaceButton extends StatelessWidget {
  final String icon;
  final void Function() onTap;
  final double size;
  final Color? backgroundColor;
  final bool hasShadow;

  const LtSurfaceButton({
    required this.icon,
    required this.onTap,
    this.size = AppSizes.s14,
    this.backgroundColor,
    this.hasShadow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.s04),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  offset: Offset.zero,
                  blurRadius: AppSizes.s03,
                  color: Colors.black.withOpacity(.08),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Image.asset(
              icon,
              width: AppSizes.s06,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
