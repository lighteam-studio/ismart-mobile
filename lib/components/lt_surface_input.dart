import 'package:flutter/material.dart';
import 'package:ismart/components/lt_surface.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSurfaceInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final List<Widget>? badges;

  const LtSurfaceInput({
    required this.hintText,
    this.controller,
    this.badges,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return LtSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            style: TextStyle(
              fontSize: AppSizes.s04,
              fontWeight: FontWeight.w600,
              height: 1,
              color: colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: AppSizes.s03),
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: colorScheme.onSurface.withOpacity(.5),
              ),
            ),
          ),
          if (badges != null && badges!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.s02),
              child: Wrap(
                spacing: AppSizes.s01,
                runSpacing: AppSizes.s01,
                direction: Axis.horizontal,
                children: badges!,
              ),
            )
        ],
      ),
    );
  }
}
