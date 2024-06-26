import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/features/basket/providers/basket_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class BasketFooter extends StatelessWidget {
  const BasketFooter({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    BasketProvider provider = Provider.of(context);

    return Container(
      padding: EdgeInsets.only(
        top: AppSizes.s03,
        left: AppSizes.s05,
        right: AppSizes.s05,
        bottom: MediaQuery.of(context).padding.bottom + AppSizes.s05,
      ),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSizes.s06),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.05),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: AppSizes.s03),
                    ),
                    Text(
                      "€${provider.totalValue.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppSizes.s05),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: colorScheme.surface,
                height: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Products",
                      style: TextStyle(fontSize: AppSizes.s03),
                    ),
                    Text(
                      "${provider.totalItems}x",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.s05,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.s03),
          LtPrimaryButton(
            label: "Continuar",
            disabled: provider.basketItems.isEmpty,
            onTap: () => provider.createTransaction(context),
          ),
        ],
      ),
    );
  }
}
