import 'dart:ui';

class LtPopupOption {
  final String label;
  final void Function() onTap;
  final String? icon;
  final Color? color;

  LtPopupOption({
    required this.label,
    required this.onTap,
    this.icon,
    this.color,
  });
}
