import 'package:flutter/material.dart';
import 'package:ismart/core/enums/payment_type.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class PaymentListTile extends StatelessWidget {
  final void Function() onTap;
  final PaymentType type;
  final double value;

  const PaymentListTile({
    required this.type,
    required this.onTap,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: AppSizes.s19,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.s05,
          ),
          child: Row(
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
                child: Center(
                  child: Image.asset(
                    AppIcons.coin,
                    width: AppSizes.s08,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.s02_5),

              // Product Information
              Expanded(
                child: Text(
                  "Dinheiro",
                  style: TextStyle(
                    fontSize: AppSizes.s04,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "€250.00",
                style: TextStyle(
                  fontSize: AppSizes.s04,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
