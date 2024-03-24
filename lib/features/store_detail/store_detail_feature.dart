import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/features/store_detail/provider/store_detail_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class StoreDetailFeature extends StatelessWidget {
  const StoreDetailFeature({super.key});

  @override
  Widget build(BuildContext context) {
    StoreDetailProvider provider = Provider.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return LtPage(
      title: "My store informations",
      action: LtIconButton(
        icon: AppIcons.trash,
        onPressed: () => provider.deleteStore(context),
        color: colorScheme.error,
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                  top: AppSizes.s04,
                  left: AppSizes.s06,
                  right: AppSizes.s06,
                  bottom: AppSizes.s06,
                ),
                children: [
                  LtTextFormField(
                    controller: provider.storeNameController,
                    label: "Store name",
                    placeholder: "Insert the store name",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.s06,
                vertical: AppSizes.s03,
              ),
              child: LtPrimaryButton(
                label: "Confirm",
                onTap: () => provider.editStore(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
