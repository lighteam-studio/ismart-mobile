import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class CategoryListTile extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const CategoryListTile({required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.s04,
            horizontal: AppSizes.s05,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
