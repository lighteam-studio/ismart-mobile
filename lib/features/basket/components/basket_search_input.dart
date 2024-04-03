import 'package:flutter/material.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class BasketSearchInput extends StatelessWidget {
  final TextEditingController controller;
  const BasketSearchInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s03_5),
            height: AppSizes.s12,
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
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: AppSizes.s04,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
              decoration: InputDecoration(
                hintText: "Search product...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withOpacity(.3),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppSizes.s02_5),
          child: LtSurfaceButton(
            icon: AppIcons.scanner,
            size: AppSizes.s12,
            backgroundColor: colorScheme.onPrimary,
            hasShadow: true,
            onTap: () {},
          ),
        )
      ],
    );
  }
}
