import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ismart/core/enums/transaction_type.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class TransactionListTile extends StatelessWidget {
  final TransactionType type;
  final double amount;
  final DateTime date;
  final void Function() onTap;

  const TransactionListTile({
    required this.type,
    required this.amount,
    required this.date,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    String formatAmount() {
      var icon = amount > 0
          ? '+'
          : amount < 0
              ? '-'
              : ' ';

      return "$icon € ${amount.abs()}";
    }

    Color color() {
      if (type == TransactionType.sale) {
        return colorScheme.onSurface;
      }

      if (type == TransactionType.deposit) {
        return colorScheme.tertiary;
      }

      return colorScheme.error;
    }

    String icon() {
      return switch (type) {
        TransactionType.deposit => AppIcons.deposit,
        TransactionType.devolution => AppIcons.devolution,
        TransactionType.reposition => AppIcons.reposition,
        TransactionType.withdrawal => AppIcons.withdrawal,
        _ => AppIcons.sale
      };
    }

    String typeTranslation() {
      var hour = DateFormat(DateFormat.HOUR24_MINUTE).format(date);

      return switch (type) {
        TransactionType.deposit => "Deposit at $hour",
        TransactionType.devolution => "Devolution at $hour",
        TransactionType.reposition => "Reposition at $hour",
        TransactionType.withdrawal => "Withdrawal at $hour",
        _ => "Sale at $hour"
      };
    }

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
                    icon(),
                    width: AppSizes.s06,
                    color: colorScheme.onSurface,
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
                      formatAmount(),
                      style: TextStyle(
                        fontSize: AppSizes.s04,
                        fontWeight: FontWeight.bold,
                        color: color(),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Product brand
                    Text(
                      typeTranslation(),
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
        ),
      ),
    );
  }
}
