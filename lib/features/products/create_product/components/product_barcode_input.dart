import 'package:flutter/material.dart';
import 'package:ismart/components/lt_popup_menu_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductBarcodeInput extends StatelessWidget {
  final bool showLabel;
  final bool canRemove;
  final void Function() onRemove;
  final TextEditingController controller;
  const ProductBarcodeInput({
    required this.showLabel,
    required this.controller,
    required this.canRemove,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    var colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: LtTextFormField(
              label: showLabel ? s.barCode : null,
              placeholder: s.placeholderBarCode,
              controller: controller,
              validators: [
                Validators.of(context).required,
              ],
            ),
          ),
          const SizedBox(width: AppSizes.s02),
          Padding(
            padding: showLabel ? const EdgeInsets.only(top: 22) : EdgeInsets.zero,
            child: LtPopupMenuButton(
              icon: AppIcons.circleEllipsis,
              options: [
                LtPopupMenuButtonOption(
                  label: "Scanner",
                  onTap: () {},
                  icon: AppIcons.scanner,
                ),
                if (canRemove)
                  LtPopupMenuButtonOption(
                    label: "Remove",
                    onTap: onRemove,
                    icon: AppIcons.trash,
                    color: colorScheme.error,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
