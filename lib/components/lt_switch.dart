import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSwitch extends StatelessWidget {
  final bool selected;
  final void Function(bool value) onChange;

  const LtSwitch({required this.selected, required this.onChange, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      height: AppSizes.s08,
      width: AppSizes.s13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s03),
        gradient: RadialGradient(
          colors: selected
              ? [
                  colorScheme.primary,
                  colorScheme.primaryContainer,
                ]
              : [
                  colorScheme.onBackground.withOpacity(.5),
                  colorScheme.onBackground.withOpacity(.5),
                ],
          center: const Alignment(-1, -1),
          radius: 4,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          AnimatedAlign(
            curve: Curves.ease,
            alignment: selected ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(milliseconds: 300),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSizes.s01),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(AppSizes.s02_5),
              ),
              width: AppSizes.s06,
              height: AppSizes.s06,
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onChange(!selected),
              ),
            ),
          )
        ],
      ),
    );
  }
}
