import 'package:flutter/material.dart';
import 'package:ismart/components/lt_switch.dart';

class LtSwitchListTitle extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function(bool value) onChange;

  const LtSwitchListTitle({
    required this.label,
    required this.selected,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(label, style: textTheme.bodyLarge),
        ),
        LtSwitch(
          onChange: onChange,
          selected: selected,
        ),
      ],
    );
  }
}
