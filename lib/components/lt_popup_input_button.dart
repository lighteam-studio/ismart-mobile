import 'package:flutter/material.dart';
import 'package:ismart/core/interfaces/lt_popup_option.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtPopupInputButton extends StatelessWidget {
  final String icon;
  final List<LtPopupOption> options;
  const LtPopupInputButton({required this.icon, required this.options, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    PopupMenuItem popupMenuItem(LtPopupOption option) {
      return PopupMenuItem(
        onTap: option.onTap,
        child: Row(
          children: [
            if (option.icon != null)
              Padding(
                padding: const EdgeInsets.only(right: AppSizes.s02),
                child: Image.asset(
                  option.icon!,
                  width: AppSizes.s06,
                  color: option.color ?? colorScheme.onSurface,
                ),
              ),
            Text(
              option.label,
              style: TextStyle(
                color: option.color ?? colorScheme.onSurface,
                fontSize: AppSizes.s03_5,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      );
    }

    return PopupMenuButton(
      position: PopupMenuPosition.under,
      color: Colors.white,
      surfaceTintColor: colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s03),
      ),
      itemBuilder: (context) => options.map((option) => popupMenuItem(option)).toList(),
      child: Container(
        width: AppSizes.s14,
        height: AppSizes.s14,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.s04),
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: AppSizes.s06,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
