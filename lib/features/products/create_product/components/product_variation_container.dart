import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_select_form_field.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class ProductVariationContainer extends StatelessWidget {
  const ProductVariationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.s03),
        boxShadow: [
          BoxShadow(blurRadius: AppSizes.s03, color: Colors.black.withOpacity(.08)),
        ],
      ),
      padding: EdgeInsets.zero,
      child: ExpansionTile(
        initiallyExpanded: true,
        iconColor: colorScheme.onSurface,
        title: Text("G - Azul"),
        shape: Border.all(color: Colors.transparent),
        childrenPadding: const EdgeInsets.only(
          left: AppSizes.s04,
          right: AppSizes.s04,
          bottom: AppSizes.s04,
        ),
        children: [
          // Name of characteristic
          const LtSelectFormField(
            label: "Tamanho",
            placeholder: "Insert your value",
            options: [],
            title: "Tamanho",
          ),
          const SizedBox(height: AppSizes.s02),

          const LtSelectFormField(
            label: "Cor",
            placeholder: "Insert your value",
            options: [],
            title: "Cor",
          ),

          const Divider(thickness: 2, height: AppSizes.s08),

          const LtTextFormField(
            label: "Sale price",
            placeholder: "Insert your sale price",
          ),
          const SizedBox(height: AppSizes.s02),

          // Type of characteristic
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: LtTextFormField(
                  label: "Estoque inicial",
                  placeholder: "Select a type",
                ),
              ),
              const SizedBox(width: AppSizes.s02),
              LtSurfaceButton(icon: AppIcons.circleEllipsis, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
