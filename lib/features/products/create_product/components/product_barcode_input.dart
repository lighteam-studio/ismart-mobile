import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ismart/components/lt_popup_input_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/interfaces/lt_popup_option.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductBarcodeInput extends StatelessWidget {
  final bool showLabel;
  final bool canRemove;
  final void Function() onRemove;
  final bool isRequired;
  final TextEditingController controller;

  const ProductBarcodeInput({
    required this.showLabel,
    required this.controller,
    required this.isRequired,
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
              mask: FilteringTextInputFormatter.digitsOnly,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              label: showLabel ? s.barCode : null,
              placeholder: s.placeholderBarCode,
              controller: controller,
              validators: isRequired ? [Validators.of(context).required] : null,
            ),
          ),
          const SizedBox(width: AppSizes.s02),
          Padding(
            padding: showLabel ? const EdgeInsets.only(top: 22) : EdgeInsets.zero,
            child: LtPopupInputButton(
              icon: AppIcons.circleEllipsis,
              options: [
                LtPopupOption(
                  label: "Scanner",
                  onTap: () {},
                  icon: AppIcons.scanner,
                ),
                if (canRemove)
                  LtPopupOption(
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
