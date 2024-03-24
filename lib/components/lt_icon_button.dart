import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtIconButton extends StatelessWidget {
  final void Function() onPressed;
  final Color? color;
  final double size;
  final double iconSize;
  final String icon;

  const LtIconButton({
    this.size = AppSizes.s10,
    this.iconSize = AppSizes.s06,
    required this.onPressed,
    required this.icon,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(999),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Image.asset(
              icon,
              fit: BoxFit.contain,
              height: iconSize,
              width: iconSize,
              color: color ?? colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
