import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/features/basket/providers/basket_item_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BasketListTile extends StatelessWidget {
  const BasketListTile({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    BasketItemProvider provider = Provider.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
      padding: const EdgeInsets.all(AppSizes.s02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s03),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: AppSizes.s03,
            color: Colors.black.withOpacity(.08),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Product image
              Container(
                height: AppSizes.s14,
                width: AppSizes.s14,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.s05),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      blurRadius: AppSizes.s03,
                      color: Colors.black.withOpacity(.08),
                    )
                  ],
                ),
                child: provider.product.thumbnail != null
                    ? FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: MemoryImage(provider.product.thumbnail!),
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Image.asset(
                          AppIcons.bag,
                          width: AppSizes.s08,
                          color: colorScheme.onSurface.withOpacity(.1),
                        ),
                      ),
              ),
              const SizedBox(width: AppSizes.s02_5),

              // Product Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Product Name
                    Text(
                      provider.product.nameWithVariations,
                      style: TextStyle(
                        fontSize: AppSizes.s03_5,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                    ),

                    // Product brand
                    Text(
                      provider.product.brand,
                      style: TextStyle(
                        fontSize: AppSizes.s03,
                        color: colorScheme.onSurface.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 130),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.s03),
                ),
                child: Row(
                  children: [
                    LtIconButton(
                      icon: AppIcons.circleMinus,
                      onPressed: () => provider.decrement(),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: provider.lengthController,
                        inputFormatters: [
                          CurrencyTextInputFormatter(decimalDigits: 0, symbol: ""),
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 1,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    LtIconButton(
                      icon: AppIcons.circlePlus,
                      onPressed: () => provider.increment(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.s01),
              Text(provider.product.unit.name),
              const SizedBox(width: AppSizes.s01),
              const Spacer(),
              Text(
                "€${provider.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                  fontSize: AppSizes.s04_5,
                ),
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
