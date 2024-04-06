import 'package:flutter/material.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/core/enums/payment_type.dart';
import 'package:ismart/features/payment/components/payment_button.dart';
import 'package:ismart/features/payment/components/payment_footer.dart';
import 'package:ismart/features/payment/components/payment_list_tile.dart';
import 'package:ismart/resources/app_sizes.dart';

class PaymentFeature extends StatelessWidget {
  const PaymentFeature({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return LtPage(
      safeAreaBottom: false,
      title: "Payment",
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.s05,
              right: AppSizes.s05,
              top: AppSizes.s03,
            ),
            child: PaymentButton(onTap: () {}),
          ),

          // Content
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                indent: AppSizes.s05,
                endIndent: AppSizes.s05,
                color: colorScheme.surface.withOpacity(.7),
              ),
              itemBuilder: (context, index) {
                return PaymentListTile(
                  type: PaymentType.creditCard,
                  onTap: () {},
                  value: 250.32,
                );
              },
            ),
          ),

          // Footer
          const PaymentFooter(),
        ],
      ),
    );
  }
}
