import 'package:flutter/material.dart';

class AppShellAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final int direction;
  const AppShellAnimatedSwitcher({required this.child, required this.direction, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.ease,
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        if (animation.value == 1) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(-.4 * direction, 0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          );
        }
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1.0 * direction, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      },
      child: child,
    );
  }
}
