import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtHollowButton extends StatelessWidget {
  final String label;
  final void Function() onTap;

  const LtHollowButton({required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: AppSizes.s14,
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppSizes.s05),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: colorScheme.onSurface,
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
