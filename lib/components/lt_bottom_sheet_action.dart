import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtBottomSheetAction<T> extends StatelessWidget {
  final String icon;
  final String label;
  final T value;
  const LtBottomSheetAction({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: AppSizes.s14,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(value),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s04),
            child: Row(
              children: [
                Image.asset(icon, width: AppSizes.s06, color: colorScheme.onSurface),
                const SizedBox(width: AppSizes.s02),
                Expanded(
                  child: Text(label),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
