import 'package:flutter/material.dart';
import 'package:ismart/components/lt_list_group_title_sliver.dart';
import 'package:ismart/components/lt_search_sliver.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/core/entities/transaction_entity.dart';
import 'package:ismart/core/enums/transaction_type.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/features/transactions/transactions_list/components/transaction_list_tile.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class TransactionsListFeature extends StatelessWidget {
  const TransactionsListFeature({super.key});

  @override
  Widget build(BuildContext context) {
    List<Group<TransactionEntity>> data = [
      Group(title: "January 25", items: [
        TransactionEntity(id: "1", type: TransactionType.sale, amount: 854.75, date: DateTime.now()),
        TransactionEntity(id: "2", type: TransactionType.devolution, amount: -247.35, date: DateTime.now()),
        TransactionEntity(id: "3", type: TransactionType.reposition, amount: -534.54, date: DateTime.now()),
        TransactionEntity(id: "4", type: TransactionType.withdrawal, amount: -120.99, date: DateTime.now()),
        TransactionEntity(id: "5", type: TransactionType.deposit, amount: 251.50, date: DateTime.now()),
      ])
    ];

    var colorScheme = Theme.of(context).colorScheme;
    return StreamBuilder(
      stream: Stream.fromFuture(Future.value(data)),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("Nenhum transação realizada cadastrado");
        }

        if (snapshot.hasError) {
          return const Text("Falha ao carregar os produtos");
        }

        List<List<Widget>> content = snapshot.data!
            .map(
              (group) => [
                LtListGroupTitleSliver(
                  content: group.title,
                ),
                SliverList.separated(
                  itemCount: group.items.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    indent: AppSizes.s05,
                    endIndent: AppSizes.s05,
                    color: colorScheme.surface.withOpacity(.7),
                  ),
                  itemBuilder: (c, i) {
                    var transaction = group.items[i];

                    return TransactionListTile(
                      amount: transaction.amount,
                      date: transaction.date,
                      type: transaction.type,
                      onTap: () {},
                    );
                  },
                )
              ],
            )
            .toList();

        return CustomScrollView(
          slivers: [
            // Search sliver
            LtSearchSliver(
              action: LtSurfaceButton(
                icon: AppIcons.circleEllipsis,
                size: AppSizes.s12,
                backgroundColor: colorScheme.onPrimary,
                hasShadow: true,
                onTap: () {},
              ),
            ),
            ...content.expand((e) => e),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom + AppSizes.s10),
            )
          ],
        );
      },
    );
  }
}
