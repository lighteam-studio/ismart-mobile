import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtBadge extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const LtBadge({
    required this.text,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s02),
        gradient: RadialGradient(
          colors: [colorScheme.primary, colorScheme.primaryContainer],
          center: const Alignment(-1, -1),
          radius: 4,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s02,
              vertical: AppSizes.s01,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.s03,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
