import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/components/lt_surface_input.dart';
import 'package:ismart/core/models/product_group_model.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class CategoryGroup extends StatefulWidget {
  final void Function() deleteGroup;
  const CategoryGroup({required this.deleteGroup, super.key});

  @override
  State<CategoryGroup> createState() => _CategoryGroupState();
}

class _CategoryGroupState extends State<CategoryGroup> {
  final TextEditingController _newCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    ProductGroupModel model = Provider.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s04),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListenableBuilder(
                  listenable: model.titleController,
                  builder: (context, child) => LtSurfaceInput(
                    valid: model.title.isNotEmpty,
                    controller: model.titleController,
                    hintText: "Grupo de produtos",
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.s02),
              LtIconButton(
                onPressed: widget.deleteGroup,
                icon: AppIcons.times,
                iconSize: AppSizes.s05,
                size: AppSizes.s08,
                color: colorScheme.onBackground,
              ),
              const SizedBox(width: AppSizes.s02)
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s02),
            itemCount: model.categories.length,
            separatorBuilder: (c, i) => Divider(
              height: 1,
              color: colorScheme.surface,
            ),
            itemBuilder: (c, i) {
              var category = model.categories[i];

              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: category.nameController,
                      style: const TextStyle(
                        fontSize: AppSizes.s04,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Categoria",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  LtIconButton(
                    onPressed: () => model.removeCategory(i),
                    icon: AppIcons.times,
                    iconSize: AppSizes.s05,
                    size: AppSizes.s08,
                    color: colorScheme.onBackground,
                  ),
                ],
              );
            },
          ),
          if (model.categories.isNotEmpty)
            Divider(
              height: 1,
              color: colorScheme.surface,
              endIndent: AppSizes.s02,
              indent: AppSizes.s02,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s02),
            child: TextField(
              controller: _newCategoryController,
              onSubmitted: (value) {
                model.addCategory(_newCategoryController.text);
                _newCategoryController.clear();
              },
              style: const TextStyle(
                fontSize: AppSizes.s04,
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                hintText: "Nova categoria",
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
