import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ismart/components/lt_bottom_sheet_header.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_secondary_button.dart';
import 'package:ismart/components/lt_select_form_field.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/entities/product_property_entity.dart';
import 'package:ismart/core/enums/product_property_type.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/interfaces/option.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/utils/validators.dart';
import 'package:uuid/uuid.dart';

enum ProductPropertyDialogAction {
  delete,
}

class ProductPropertyDialog extends StatefulWidget {
  final ProductPropertyEntity? property;
  const ProductPropertyDialog({this.property, super.key});

  @override
  State<ProductPropertyDialog> createState() => _ProductPropertyDialogState();
}

class _ProductPropertyDialogState extends State<ProductPropertyDialog> {
  final String propertyId = const Uuid().v4();

  final GlobalKey<FormState> _form = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final List<TextEditingController> _values = [
    TextEditingController(),
  ];
  ProductPropertyType _type = ProductPropertyType.text;
  bool _validateOnInput = false;

  void _submit() {
    setState(() {
      _validateOnInput = true;
    });

    var valid = _form.currentState?.validate() ?? false;
    if (valid) {
      Navigator.of(context).pop(
        ProductPropertyEntity(
          productId: "",
          propertyId: propertyId,
          name: _nameController.text,
          type: _type,
          propertyValues: _values.map((e) => e.text).toList(),
        ),
      );
    }
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              //
              // SM Select Header
              LtBottomSheetHeader(
                title: "Product property",
                actions: [
                  if (widget.property != null)
                    LtIconButton(
                      icon: AppIcons.trash,
                      iconSize: AppSizes.s06,
                      color: colorScheme.error,
                      onPressed: () => Navigator.of(context).pop(
                        ProductPropertyDialogAction.delete,
                      ),
                    ),
                ],
              ),

              Expanded(
                child: Form(
                  key: _form,
                  autovalidateMode: _validateOnInput ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  child: ListView(
                    padding: const EdgeInsets.all(AppSizes.s06),
                    children: [
                      // Name of Property
                      LtTextFormField(
                        label: "Property name",
                        placeholder: "Insert the property name",
                        controller: _nameController,
                        validators: [
                          Validators.of(context).required,
                        ],
                      ),
                      const SizedBox(height: AppSizes.s04),

                      // Type of Property
                      LtSelectFormField(
                        label: "Property type",
                        value: _type,
                        onChange: (type) => setState(() {
                          _type = type ?? ProductPropertyType.text;
                          for (var value in _values) {
                            value.clear();
                          }
                        }),
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

                      const SizedBox(height: AppSizes.s04),

                      ..._values.mapIndexed(
                        (i, e) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.s02),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: LtTextFormField(
                                  mask: _type == ProductPropertyType.number
                                      ? FilteringTextInputFormatter.digitsOnly //
                                      : null,
                                  controller: e,
                                  label: i == 0 ? "Available values" : null,
                                  keyboardType: _type == ProductPropertyType.number
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
                                    onTap: () => setState(() {
                                      _values.removeAt(i);
                                    }),
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
                        onTap: () {
                          setState(() {
                            _values.add(TextEditingController());
                          });
                        },
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
      ),
    );
  }
}
