import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSurfaceButton extends StatelessWidget {
  final String icon;
  final void Function() onTap;
  const LtSurfaceButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: AppSizes.s12,
      height: AppSizes.s12,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSizes.s04),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: AppSizes.s03,
            color: Colors.black.withOpacity(.08),
          ),
        ],
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
