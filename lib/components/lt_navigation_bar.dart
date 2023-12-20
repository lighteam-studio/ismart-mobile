import 'package:flutter/material.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtNavigationMenu {
  final String icon;
  final String label;
  final String routeName;

  LtNavigationMenu({required this.icon, required this.label, required this.routeName});
}

class LtNavigationBar extends StatelessWidget {
  final void Function(String routeName) onNavigate;
  final String selectedMenu;
  final List<LtNavigationMenu> menus;

  const LtNavigationBar({
    required this.onNavigate,
    required this.selectedMenu,
    required this.menus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: AppSizes.s14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s05),
        gradient: RadialGradient(
          colors: [colorScheme.primary, colorScheme.primaryContainer],
          center: const Alignment(-1, -1),
          radius: 4,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              AppImages.circles,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned.fill(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) {
                var menu = menus[i];

                return LtNavigationBarItem(
                  icon: menu.icon,
                  label: menu.label,
                  onTap: () => onNavigate(menu.routeName),
                  selected: menu.routeName == selectedMenu,
                );
              },
              separatorBuilder: (c, i) => VerticalDivider(
                width: 1,
                color: colorScheme.onPrimary,
                thickness: 1,
                indent: AppSizes.s02,
                endIndent: AppSizes.s02,
              ),
              itemCount: menus.length,
            ),
          )
        ],
      ),
    );
  }
}

class LtNavigationBarItem extends StatelessWidget {
  final bool selected;
  final String icon;
  final String label;
  final void Function() onTap;

  const LtNavigationBarItem({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.s02),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s01_5),
            decoration: BoxDecoration(
              color: selected ? colorScheme.onPrimary.withOpacity(.1) : colorScheme.onPrimary.withOpacity(0),
              borderRadius: BorderRadius.circular(AppSizes.s03),
            ),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: AppSizes.s06,
                  color: colorScheme.onPrimary,
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, animation) => SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                    axisAlignment: 0,
                    child: child,
                  ),
                  child: selected
                      ? Padding(
                          padding: const EdgeInsets.only(left: AppSizes.s01_5),
                          child: Center(
                            child: Text(
                              label,
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w500,
                                fontSize: AppSizes.s03_5,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
