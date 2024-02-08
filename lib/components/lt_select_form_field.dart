import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_select_dialog.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtSelectFormField<T> extends StatelessWidget {
  final String label;
  final String placeholder;
  final T? value;
  final String title;
  final List<Group<Option<T>>> options;
  final List<String? Function(T? value)>? validators;
  final void Function(T? value)? onChange;

  const LtSelectFormField({
    required this.label,
    required this.placeholder,
    required this.title,
    this.validators,
    this.value,
    this.onChange,
    required this.options,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: value,
      onSaved: onChange,
      // Valiação
      validator: (value) {
        if (validators != null) {
          for (var validator in validators!) {
            var error = validator(value);
            if (error != null) return error;
          }
        }
        return null;
      },
      builder: (field) {
        var colorScheme = Theme.of(context).colorScheme;
        var textTheme = Theme.of(context).textTheme;

        var selectedValue = options
            .expand(
              (element) => element.items,
            )
            .firstWhereOrNull(
              (element) => element.key == value,
            );

        /// On open available options
        void openOptions() async {
          final result = await showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            builder: (context) => LtSelectDialog(
              title: title,
              elements: options,
            ),
          );

          if (result is Option) {
            field.didChange(result.key);
            field.save();
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Label
            Text(
              label,
              style: textTheme.labelMedium,
            ),
            const SizedBox(height: AppSizes.s01),

            // Container
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppSizes.s03),
                border: Border.all(
                  color: field.errorText != null && field.errorText!.isNotEmpty
                      ? colorScheme.error //
                      : colorScheme.surface,
                  width: 2,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: openOptions,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.s04),
                    child: Text(
                      selectedValue?.label ?? placeholder,
                      style: TextStyle(
                        color: selectedValue != null ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(.5),
                        fontSize: AppSizes.s04,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (field.errorText != null && field.errorText!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.s00_5),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: colorScheme.error,
                    fontSize: AppSizes.s03,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
