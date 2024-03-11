import 'package:flutter/material.dart';
import 'package:ismart/components/lt_surface.dart';
import 'package:ismart/resources/app_sizes.dart';

class GroupListTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const GroupListTile({required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
        child: LtSurface(
          padding: EdgeInsets.zero,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.s03_5,
                  horizontal: AppSizes.s04,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
