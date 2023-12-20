import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtProgressBar extends StatelessWidget {
  final double progress;
  const LtProgressBar({required this.progress, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: AppSizes.s02_5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s02_5),
        color: colorScheme.surface,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Container(
                height: AppSizes.s02_5,
                width: constraints.maxWidth * progress,
                constraints: const BoxConstraints(minWidth: AppSizes.s03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.s04),
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
