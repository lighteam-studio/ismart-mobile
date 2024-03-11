import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_secondary_button.dart';
import 'package:ismart/components/lt_select_form_field.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/enums/product_property_type.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/features/products/create_product/providers/product_property_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class ProductPropertyContainer extends StatelessWidget {
  const ProductPropertyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    ProductPropertyProvider property = Provider.of(context);

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
              // Name of Property
              LtTextFormField(
                label: "Property name",
                placeholder: "Insert the property name",
                controller: property.nameController,
              ),
              const SizedBox(height: AppSizes.s02),

              // Type of Property
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: LtSelectFormField(
                      label: "Property type",
                      onChange: (type) => property.propertyType = type ?? ProductPropertyType.text,
                      options: [
                        Group(
                          title: "Types",
                          items: [
                            Option(key: ProductPropertyType.number, label: "Number"),
                            Option(key: ProductPropertyType.color, label: "Color"),
                            Option(key: ProductPropertyType.text, label: "Text"),
                          ],
                        )
                      ],
                      placeholder: "Select a type",
                      title: "Property type",
                    ),
                  ),
                  const SizedBox(width: AppSizes.s02),
                  LtSurfaceButton(icon: AppIcons.camera, onTap: () {}),
                ],
              ),
              const SizedBox(height: AppSizes.s02),

              // Property value
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
