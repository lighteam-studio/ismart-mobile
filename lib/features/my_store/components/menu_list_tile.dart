import 'package:flutter/material.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class MenuListTile extends StatelessWidget {
  final void Function() onTap;
  final String icon;
  final String label;

  const MenuListTile({
    required this.onTap,
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: AppSizes.s19,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.s05,
          ),
          child: Row(
            children: [
              // Product image
              Container(
                height: AppSizes.s12,
                width: AppSizes.s12,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.s04),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      blurRadius: AppSizes.s03,
                      color: Colors.black.withOpacity(.08),
                    )
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    icon,
                    width: AppSizes.s06,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.s02_5),

              // Product Information
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: AppSizes.s04,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Image.asset(
                AppIcons.chevronRight,
                color: colorScheme.onSurface,
                width: AppSizes.s04,
              )
            ],
          ),
        ),
      ),
    );
  }
}
