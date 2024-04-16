import 'package:flutter/material.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/components/lt_popup_input_button.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/core/enums/payment_type.dart';
import 'package:ismart/core/interfaces/lt_popup_option.dart';
import 'package:ismart/features/payment/components/payment_method_list_tile.dart';
import 'package:ismart/features/payment/provider/payment_method_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class PaymentMethodDialog extends StatefulWidget {
  final double maxValue;
  final String transactionId;

  const PaymentMethodDialog({
    required this.maxValue,
    required this.transactionId,
    super.key,
  });

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentMethodProvider(
        maxValue: widget.maxValue,
        transactionId: widget.transactionId,
      ),
      builder: (context, child) {
        PaymentMethodProvider provider = Provider.of(context);
        ColorScheme colorScheme = Theme.of(context).colorScheme;

        return LtPage(
          safeAreaBottom: false,
          title: "Add payment",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.s01),
                  children: [
                    // Money payment
                    PaymentMethodListTile(
                      selected: provider.paymentType == PaymentType.money,
                      type: PaymentType.money,
                      onTap: () => provider.paymentType = PaymentType.money,
                    ),
                    const Divider(),

                    // Credit card
                    PaymentMethodListTile(
                      selected: provider.paymentType == PaymentType.creditCard,
                      type: PaymentType.creditCard,
                      onTap: () => provider.paymentType = PaymentType.creditCard,
                    ),
                    const Divider(),

                    // Debit card
                    PaymentMethodListTile(
                      selected: provider.paymentType == PaymentType.debitCard,
                      type: PaymentType.debitCard,
                      onTap: () => provider.paymentType = PaymentType.debitCard,
                    ),
                    const Divider(),

                    // Digital payments
                    PaymentMethodListTile(
                      selected: provider.paymentType == PaymentType.digital,
                      type: PaymentType.digital,
                      onTap: () => provider.paymentType = PaymentType.digital,
                    ),
                  ],
                ),
              ),

              // Footer
              Container(
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
                          child: LtTextFormField(
                            controller: provider.valueController,
                            mask: provider.currencyFormatter,
                            placeholder: "Insert the value",
                          ),
                        ),
                        const SizedBox(width: AppSizes.s02),
                        LtPopupInputButton(
                          icon: AppIcons.circleEllipsis,
                          options: [
                            LtPopupOption(
                              label: "Total value",
                              onTap: () => provider.insertTotalValue(),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: AppSizes.s03),
                    AnimatedBuilder(
                      animation: provider.valueController,
                      builder: (context, child) => LtPrimaryButton(
                        label: "Continuar",
                        disabled: provider.paymentType == null || provider.paymentValue == 0,
                        onTap: () => provider.submitPayment(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
