import 'package:flutter/material.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/resources/app_sizes.dart';

class CompanyCategoryListTile extends StatelessWidget {
  final ProductGroupEntity group;
  final bool selected;
  final void Function() onTap;

  const CompanyCategoryListTile({
    required this.selected,
    required this.group,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s03),
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            blurRadius: selected ? 7 : 0,
            color: colorScheme.primary.withOpacity(.5),
          ),
        ],
        border: Border.all(
          color: selected ? colorScheme.primary : colorScheme.surface,
          width: 1,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.s03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      "lib/assets/product_groups/${group.productGroupId}.png",
                      width: AppSizes.s22_5,
                      height: AppSizes.s22_5,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.s02),
                Text(
                  group.title,
                  textAlign: TextAlign.center,
                  style: textTheme.labelMedium,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
