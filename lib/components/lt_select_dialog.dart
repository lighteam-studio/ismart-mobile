import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/components/lt_list_group_title_sliver.dart';
import 'package:ismart/components/lt_search_sliver.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSelectDialog extends StatefulWidget {
  final String title;
  final List<Group<Option>> elements;

  const LtSelectDialog({required this.title, required this.elements, super.key});

  @override
  State<LtSelectDialog> createState() => _LtSelectDialogState();
}

class _LtSelectDialogState extends State<LtSelectDialog> {
  String _search = "";

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height * 0.85;

    var filteredOptions = _search.isEmpty
        ? widget.elements
        : widget.elements
            .map((group) {
              return Group<Option>(
                title: group.title,
                items: group.items
                    .where(
                      (option) => option.label.toLowerCase().contains(_search.toLowerCase()),
                    )
                    .toList(),
              );
            })
            .where((element) => element.items.isNotEmpty)
            .toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSizes.s05),
        ),
      ),
      height: height,
      child: SafeArea(
        child: Column(
          children: [
            //
            // SM Select Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s02),
              height: AppSizes.s16,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: colorScheme.surface)),
              ),
              child: Stack(
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: LtIconButton(
                      icon: AppIcons.chevronDown,
                      iconSize: AppSizes.s06,
                      color: colorScheme.onSurface,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),

                  // Title
                  Center(
                    child: Text(
                      widget.title,
                      style: textTheme.displaySmall,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // Search bar
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.s02),
                    sliver: LtSearchSliver(
                      onSearchChange: (value) => setState(() => _search = value),
                    ),
                  ),
                  ...filteredOptions
                      .map(
                        (group) => [
                          LtListGroupTitleSliver(
                            content: group.title,
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.only(bottom: AppSizes.s03),
                            sliver: SliverList.separated(
                              itemCount: group.items.length,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                thickness: 1,
                                indent: AppSizes.s05,
                                endIndent: AppSizes.s05,
                                color: colorScheme.surface.withOpacity(.7),
                              ),
                              itemBuilder: (c, i) {
                                var element = group.items[i];

                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context).pop(element),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.s07,
                                        vertical: AppSizes.s03,
                                      ),
                                      child: Text(
                                        element.label,
                                        style: textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                      .flattened
                      .toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
