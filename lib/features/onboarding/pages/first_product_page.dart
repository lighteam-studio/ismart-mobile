import 'package:flutter/material.dart';
import 'package:ismart/features/onboarding/providers/onboarding_provider.dart';
import 'package:ismart/features/products/create_product/pages/product_form_page.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class FirstProductPage extends StatelessWidget {
  const FirstProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    OnboardingProvider provider = Provider.of(context);

    return ChangeNotifierProvider.value(
      value: provider.productForm,
      child: ProductFormPage(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
        header: Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.s06),
          child: Text(
            "Cadastre seu primeiro produto, é super fácil 😁",
            style: textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
