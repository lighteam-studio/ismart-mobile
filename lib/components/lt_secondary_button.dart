import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSecondaryButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final Color? textColor;

  const LtSecondaryButton({
    required this.label,
    required this.onTap,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: AppSizes.s14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s03),
        color: colorScheme.surface,
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor ?? colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: AppSizes.s04,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
