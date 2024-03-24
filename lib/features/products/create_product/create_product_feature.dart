import 'package:flutter/material.dart';
import 'package:ismart/features/products/create_product/pages/product_form_page.dart';
import 'package:ismart/features/products/create_product/pages/product_variations_page.dart';
import 'package:ismart/features/products/create_product/providers/create_product_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class CreateProductFeature extends StatelessWidget {
  const CreateProductFeature({super.key});

  @override
  Widget build(BuildContext context) {
    CreateProductProvider provider = Provider.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    Widget createProductStep(bool active) {
      return Expanded(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s03),
            color: active //
                ? colorScheme.primary
                : colorScheme.surface,
          ),
        ),
      );
    }

    return Column(
      children: [
        // Steps bar
        Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.s12,
            right: AppSizes.s12,
            top: AppSizes.s03,
            bottom: AppSizes.s03,
          ),
          child: SizedBox(
              height: AppSizes.s02,
              child: AnimatedBuilder(
                animation: provider.pageController,
                builder: (context, child) {
                  var currentPage = provider.pageController.hasClients && provider.pageController.page != null
                      ? provider.pageController.page!
                      : 0.0;
                  return Row(
                    children: [
                      createProductStep(currentPage >= 0),
                      const SizedBox(width: AppSizes.s02),
                      createProductStep(currentPage >= 0.5),
                    ],
                  );
                },
              )),
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: provider.pageController,
            children: const [
              ProductFormPage(),
              ProductVariationsPage(),
            ],
          ),
        ),
      ],
    );
  }
}
