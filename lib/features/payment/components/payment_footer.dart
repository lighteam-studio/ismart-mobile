import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/resources/app_sizes.dart';

class PaymentFooter extends StatelessWidget {
  const PaymentFooter({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

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
              const Expanded(
                child: Column(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: AppSizes.s03),
                    ),
                    Text(
                      "€515,99",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppSizes.s05),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: colorScheme.surface,
                height: 20,
              ),
              const Expanded(
                child: Column(
                  children: [
                    Text(
                      "Restante",
                      style: TextStyle(fontSize: AppSizes.s03),
                    ),
                    Text(
                      "€515,99",
                      style: TextStyle(
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
