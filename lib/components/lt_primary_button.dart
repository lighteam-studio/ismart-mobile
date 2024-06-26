import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtPrimaryButton extends StatelessWidget {
  final String label;
  final bool disabled;
  final void Function() onTap;

  const LtPrimaryButton({
    required this.label,
    required this.onTap,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: AppSizes.s14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s05),
        gradient: RadialGradient(
          colors: disabled
              ? [
                  colorScheme.surface,
                  colorScheme.surface,
                ]
              : [
                  colorScheme.primary,
                  colorScheme.primaryContainer,
                ],
          center: const Alignment(-1, -1),
          radius: 4,
        ),
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
                color: disabled ? colorScheme.onSurface.withOpacity(.5) : colorScheme.onPrimary,
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
