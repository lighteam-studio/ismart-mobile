import 'package:flutter/material.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtFilePicker extends StatelessWidget {
  const LtFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: AppSizes.s32,
      width: AppSizes.s32,
      child: Material(
        color: colorScheme.surface,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppSizes.s03),
        child: InkWell(
          onTap: () {},
          child: Center(
            child: Image.asset(
              AppImages.camera,
              width: AppSizes.s14,
              color: colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}
