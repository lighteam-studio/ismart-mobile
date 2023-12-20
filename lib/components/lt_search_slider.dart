import 'package:flutter/material.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSearchSliver extends StatelessWidget {
  const LtSearchSliver({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      toolbarHeight: AppSizes.s18,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: colorScheme.surface,
      floating: true,
      flexibleSpace: Container(
        padding: const EdgeInsets.only(
          left: AppSizes.s05,
          right: AppSizes.s05,
          top: AppSizes.s03,
          bottom: AppSizes.s03,
        ),
        child: Row(
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
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: AppSizes.s04,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                  decoration: InputDecoration(
                      hintText: "Buscar produto...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.3))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.s02_5),
              child: LtSurfaceButton(
                icon: AppIcons.filter,
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
