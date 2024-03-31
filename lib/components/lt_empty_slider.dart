import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtEmptySliver extends StatelessWidget {
  final String text;
  const LtEmptySliver({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.s06),
        child: Text(
          text,
          style: textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
