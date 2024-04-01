import 'package:flutter/material.dart';
import 'package:ismart/components/lt_bottom_sheet_header.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/enums/dialog_action_enum.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/utils/validators.dart';
import 'package:uuid/uuid.dart';

class CategoryDetailDialog extends StatefulWidget {
  final ProductCategoryEntity? category;
  final String groupId;

  const CategoryDetailDialog({
    required this.groupId,
    this.category,
    super.key,
  });

  @override
  State<CategoryDetailDialog> createState() => _CategoryDetailDialogState();
}

class _CategoryDetailDialogState extends State<CategoryDetailDialog> {
  final GlobalKey<FormState> _form = GlobalKey();
  late final TextEditingController _nameController;

  void _submit() {
    var isValid = _form.currentState?.validate() ?? false;

    if (!isValid) return;

    Navigator.of(context).pop(
      ProductCategoryEntity(
        productCategoryId: widget.category != null
            ? widget.category!.productCategoryId //
            : const Uuid().v4(),
        name: _nameController.text,
        productGroupId: widget.groupId,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = widget.category != null
        ? TextEditingController(text: widget.category!.name) //
        : TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height * 0.85;

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
            LtBottomSheetHeader(
              title: widget.category != null ? "Edit category" : "Create category",
              actions: [
                if (widget.category != null)
                  LtIconButton(
                    icon: AppIcons.trash,
                    iconSize: AppSizes.s06,
                    color: colorScheme.error,
                    onPressed: () => Navigator.of(context).pop(
                      DialogActionEnum.delete,
                    ),
                  )
              ],
            ),

            Expanded(
              child: Form(
                key: _form,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: const EdgeInsets.all(AppSizes.s06),
                  children: [
                    // Name of Property
                    LtTextFormField(
                      label: "Category name",
                      placeholder: "Insert the category name",
                      controller: _nameController,
                      validators: [
                        Validators.of(context).required,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.s06,
                vertical: AppSizes.s03,
              ),
              child: LtPrimaryButton(
                label: "Confirm",
                onTap: _submit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
