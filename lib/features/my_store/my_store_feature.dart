import 'package:flutter/material.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/features/my_store/components/menu_list_tile.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/router/app_router.dart';

class MyStoreFeature extends StatelessWidget {
  const MyStoreFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return LtPage(
      title: "My store",
      child: ListView(
        children: [
          MenuListTile(
            onTap: () => Navigator.of(context).pushNamed(AppRouter.storeDetail),
            icon: AppIcons.shopOutline,
            label: "My store informations",
          )
        ],
      ),
    );
  }
}
