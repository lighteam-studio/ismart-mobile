import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String placeholder;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType keyboardType;
  final Function? onSubmit;
  final bool obscureText;
  final bool disabled;
  final TextInputFormatter? mask;
  final List<String? Function(String value)>? validators;

  const LtTextFormField({
    this.label,
    this.mask,
    this.placeholder = '',
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.nextFocusNode,
    this.validators,
    this.obscureText = false,
    this.disabled = false,
    this.controller,
    this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.s01),
            child: Text(
              label!,
              style: textTheme.labelMedium,
            ),
          ),
        TextFormField(
          inputFormatters: mask != null ? [mask!] : null,
          onFieldSubmitted: (_) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else if (onSubmit != null) {
              onSubmit!();
            }
          },
          style: const TextStyle(
            fontSize: AppSizes.s04,
            fontWeight: FontWeight.w400,
          ),
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withOpacity(.5),
            ),
            alignLabelWithHint: false,
            hintText: placeholder,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSizes.s04,
              horizontal: AppSizes.s04,
            ),
            fillColor: colorScheme.surface,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.surface, width: 2),
              borderRadius: BorderRadius.circular(AppSizes.s03),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
              borderRadius: BorderRadius.circular(AppSizes.s03),
            ),
          ),
        ),
      ],
    );
  }
}
