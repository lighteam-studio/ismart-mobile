import 'package:flutter/material.dart';
import 'package:ismart/core/enums/payment_type.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class PaymentMethodListTile extends StatelessWidget {
  final bool selected;
  final PaymentType type;
  final void Function() onTap;

  const PaymentMethodListTile({
    required this.selected,
    required this.onTap,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    String label() {
      if (type == PaymentType.creditCard) {
        return "Cartão de crédito";
      }
      if (type == PaymentType.debitCard) {
        return "Cartão de débito";
      }
      if (type == PaymentType.digital) {
        return "Pagamento digital";
      }
      return "Numerário";
    }

    String icon() {
      if (type == PaymentType.creditCard) {
        return AppIcons.creditCard;
      }
      if (type == PaymentType.debitCard) {
        return AppIcons.creditCard;
      }
      if (type == PaymentType.digital) {
        return AppIcons.qrcode;
      }
      return AppIcons.money;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.s05,
            vertical: AppSizes.s03,
          ),
          child: Row(
            children: [
              // Product image
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: AppSizes.s14,
                width: AppSizes.s14,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: selected ? colorScheme.primary : colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(AppSizes.s05),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      blurRadius: AppSizes.s03,
                      color: Colors.black.withOpacity(.08),
                    )
                  ],
                ),

                //
                child: Center(
                  child: Image.asset(
                    icon(),
                    width: AppSizes.s07,
                    color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.s02_5),

              // Product Information
              Expanded(
                child: Text(
                  label(),
                  style: TextStyle(
                    fontSize: AppSizes.s04,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
