import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtListGroupTitleSliver extends StatelessWidget {
  final String content;
  const LtListGroupTitleSliver({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: AppSizes.s07,
      flexibleSpace: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.s05,
              right: AppSizes.s05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.s02),
                    child: Text(
                      content,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: AppSizes.s04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 3,
                  color: colorScheme.surface,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
