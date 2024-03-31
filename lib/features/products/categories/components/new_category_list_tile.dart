import 'package:flutter/material.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class NewCategoryListTile extends StatelessWidget {
  final void Function() onTap;
  const NewCategoryListTile({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.s03,
            horizontal: AppSizes.s09,
          ),
          child: Row(
            children: [
              Image.asset(
                AppIcons.circlePlus,
                width: AppSizes.s06,
                color: colorScheme.onSurface.withOpacity(.4),
              ),
              const SizedBox(width: AppSizes.s02),
              Expanded(
                child: Text(
                  "Add new category",
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(.4),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
