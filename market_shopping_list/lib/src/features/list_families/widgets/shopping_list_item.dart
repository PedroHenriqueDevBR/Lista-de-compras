import 'package:flutter/material.dart';

import '../../../core/colors_util.dart';
import '../../../shared/models/shopping_list.dart';

class ShoppinglistItem extends StatelessWidget {
  ShoppingList shoppingList;
  Function onTap;

  ShoppinglistItem({
    Key? key,
    required this.shoppingList,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.shopping_cart_outlined),
      trailing: shoppingList.isDone ? Icon(Icons.check) : null,
      title: Text(
        shoppingList.title,
        style: TextStyle(),
      ),
      subtitle: Text(
        shoppingList.description != null ? shoppingList.description! : '',
        style: TextStyle(),
      ),
      selectedTileColor: AppColors.primaryColor,
      onTap: () {
        onTap();
      },
    );
  }
}
