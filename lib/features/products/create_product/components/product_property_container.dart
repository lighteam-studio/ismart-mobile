import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_secondary_button.dart';
import 'package:ismart/components/lt_select_form_field.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class ProductPropertyContainer extends StatelessWidget {
  const ProductPropertyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.s04),
      child: DottedBorder(
        dashPattern: const [8, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(AppSizes.s05),
        borderPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        color: colorScheme.surface,
        strokeWidth: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s04, vertical: AppSizes.s03),
          child: Column(
            children: [
              // Name of characteristic
              const LtTextFormField(
                label: "Characteristic name",
                placeholder: "Insert the characteristic name",
              ),
              const SizedBox(height: AppSizes.s02),

              // Type of characteristic
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: LtSelectFormField(
                      label: "Characteristic type",
                      options: [],
                      placeholder: "Select a type",
                      title: "Characteristic type",
                    ),
                  ),
                  const SizedBox(width: AppSizes.s02),
                  LtSurfaceButton(icon: AppIcons.camera, onTap: () {}),
                ],
              ),
              const SizedBox(height: AppSizes.s02),

              // Characteristic value
              const Padding(
                padding: EdgeInsets.only(bottom: AppSizes.s02),
                child: LtTextFormField(
                  label: "Values",
                  placeholder: "Insert your value",
                ),
              ),
              LtSecondaryButton(
                label: "New value",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
