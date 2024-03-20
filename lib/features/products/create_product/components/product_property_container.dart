import 'package:collection/collection.dart';
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
import 'package:ismart/utils/validators.dart';
import 'package:provider/provider.dart';

class ProductPropertyContainer extends StatelessWidget {
  final void Function() onRemove;
  final bool removable;

  const ProductPropertyContainer({
    required this.onRemove,
    required this.removable,
    super.key,
  });

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
              LtSelectFormField(
                label: "Property type",
                value: property.type,
                onChange: (type) => property.type = type ?? ProductPropertyType.text,
                options: [
                  Group(
                    title: "Types",
                    items: [
                      Option(key: ProductPropertyType.number, label: "Number"),
                      Option(key: ProductPropertyType.text, label: "Text"),
                    ],
                  )
                ],
                placeholder: "Select a type",
                title: "Property type",
              ),

              const SizedBox(height: AppSizes.s02),

              ...property.values.mapIndexed(
                (i, e) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.s02),
                  child: Row(
                    children: [
                      Expanded(
                        child: LtTextFormField(
                          controller: e,
                          label: i == 0 ? "Available values" : null,
                          keyboardType: property.type == ProductPropertyType.number
                              ? TextInputType.number //
                              : TextInputType.text,
                          placeholder: "Insert your value",
                          validators: [
                            Validators.of(context).required,
                          ],
                        ),
                      ),
                      if (i > 0)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: AppSizes.s02,
                          ),
                          child: LtSurfaceButton(
                            icon: AppIcons.trash,
                            onTap: () => property.removeValue(i),
                            iconColor: colorScheme.error,
                          ),
                        )
                    ],
                  ),
                ),
              ),

              // Property value

              LtSecondaryButton(
                label: "New value",
                onTap: () => property.addValue(),
              ),

              if (removable)
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.s02),
                  child: LtSecondaryButton(
                    label: "Remove property",
                    onTap: onRemove,
                    textColor: colorScheme.error,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
