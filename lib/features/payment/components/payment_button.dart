import 'package:flutter/material.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class PaymentButton extends StatelessWidget {
  final void Function() onTap;
  const PaymentButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: AppSizes.s12,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSizes.s04),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: AppSizes.s03,
            color: Colors.black.withOpacity(.08),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s03),
            child: Row(
              children: [
                Image.asset(
                  AppIcons.coin,
                  width: AppSizes.s06,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSizes.s02),
                Text(
                  "Adicionar pagamento",
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
