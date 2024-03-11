import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LtSearchSliver extends StatelessWidget {
  final void Function(String value)? onSearchChange;
  final String? placeholder;
  final Widget? action;

  const LtSearchSliver({this.placeholder, this.onSearchChange, this.action, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    final s = S.of(context);

    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: AppSizes.s18,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: colorScheme.surface,
      floating: true,
      flexibleSpace: Container(
        padding: const EdgeInsets.only(
          left: AppSizes.s05,
          right: AppSizes.s05,
          top: AppSizes.s03,
          bottom: AppSizes.s03,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s03_5),
                height: AppSizes.s12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.s04),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      blurRadius: AppSizes.s03,
                      color: Colors.black.withOpacity(.08),
                    )
                  ],
                ),
                child: TextField(
                  onChanged: onSearchChange,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: AppSizes.s04,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                  decoration: InputDecoration(
                      hintText: placeholder ?? s.searchPlaceholder,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.3))),
                ),
              ),
            ),
            if (action != null)
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.s02_5),
                child: action!,
              )
          ],
        ),
      ),
    );
  }
}
