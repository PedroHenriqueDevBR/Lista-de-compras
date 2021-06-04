import 'package:flutter/material.dart';

import 'package:market_shopping_list/src/core/colors_util.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class ShoppinglistItem extends StatelessWidget {
  ShoppingList shoppingList;

  ShoppinglistItem({
    Key? key,
    required this.shoppingList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.shopping_cart_outlined),
      trailing: Icon(Icons.arrow_forward_ios),
      title: Text(
        shoppingList.title,
        style: TextStyle(),
      ),
      subtitle: Text(
        shoppingList.description != null ? shoppingList.description! : '',
        style: TextStyle(),
      ),
      selectedTileColor: AppColors.primaryColor,
    );
  }
}
