import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtBottomSheetHeader extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const LtBottomSheetHeader({required this.title, this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s02),
      height: AppSizes.s16,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.surface)),
      ),
      child: Stack(
        children: [
          // Back button
          if (Navigator.of(context).canPop())
            Align(
              alignment: Alignment.centerLeft,
              child: LtIconButton(
                icon: AppIcons.chevronDown,
                iconSize: AppSizes.s06,
                color: colorScheme.onSurface,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

          // Title
          Center(
            child: Text(
              title,
              style: textTheme.displaySmall,
            ),
          ),

          // Back button
          if (actions != null)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),
            ),
        ],
      ),
    );
  }
}
