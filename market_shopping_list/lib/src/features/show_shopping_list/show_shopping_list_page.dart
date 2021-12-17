import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../shared/dal/purchase_item_dal.dart';
import '../../shared/dal/shopping_list_dal.dart';
import '../../shared/dal/sqlite_sql/purchase_item_sqlite_sql.dart';
import '../../shared/dal/sqlite_sql/shopping_list_sqlite_sql.dart';
import '../../shared/models/purchase_item.dart';
import '../../shared/models/shopping_list.dart';
import 'show_shopping_list_controller.dart';
import 'widgets/dialogs_widget.dart';
import 'widgets/header_widget.dart';

class ShowShoppingListPage extends StatefulWidget {
  ShoppingList shopping;
  ShowShoppingListPage({
    Key? key,
    required this.shopping,
  }) : super(key: key);
  @override
  SshoSshopping_listLatePage createState() => SshoSshopping_listLatePage();
}

class SshoSshopping_listLatePage extends State<ShowShoppingListPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ShowShoppingListController controller;

  @override
  void initState() {
    controller = ShowShoppingListController(
      shoppingList: widget.shopping,
      shoppingStorage: ShoppingListDAL(
        shoppingListSQL: ShoppingListSQLite(),
        purchaseItemSQL: PurchaseItemSQLite(),
      ),
      itemStorage: PurchaseItemDAL(
        purchaseItemSQL: PurchaseItemSQLite(),
      ),
    );
    controller.isDone.addListener(() {
      setState(() {});
    });
    controller.changeState.addListener(() {
      setState(() {});
    });
    controller.itens.addListener(() {
      controller.getTotal();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                RxBuilder(
                  builder: (context) => HeaderWidget(
                    title: controller.shoppingList.value.title,
                    description: controller.shoppingList.value.description != null ? controller.shoppingList.value.description! : '',
                    isDone: controller.shoppingList.value.isDone,
                    creationDate: controller.creationDate(),
                    total: controller.formatDoubleValue(controller.total.value),
                    doneFunction: () {
                      controller.toggleDoneShoppingList();
                    },
                    deleteShoppingListFunction: () {
                      controller.deleteShoppingList();
                    },
                    goToEditShoppingListPageFunction: () {
                      controller.goToEditShoppingListPage(context);
                    },
                  ),
                ),
                RxBuilder(
                  builder: (context) => ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.itens.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (_, index) {
                      PurchaseItem item = controller.itens[index];
                      return ListTile(
                        leading: Icon(Icons.shopping_basket_outlined),
                        title: Text('${item.quantity} X ${item.productName}'),
                        subtitle: Text('Total: R\$ ${controller.formatDoubleValue(item.quantity * item.price)}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => AppDialogs.confirmRemoveItem(
                              item: item,
                              confirmFunction: () {
                                controller.removeItem(item);
                              }),
                        ),
                        onTap: () {
                          AppDialogs.showAddItemDialog(
                            formKey: formKey,
                            onSaveName: (value) => controller.purchaseItem.productName = value!,
                            onSavePrice: (value) => controller.purchaseItem.price = value!,
                            onSaveQuantity: (value) => controller.purchaseItem.quantity = value,
                            onSaveButton: () {
                              controller.saveItem(purchaseItem: item);
                            },
                            item: item,
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 75.0),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Item'),
          onPressed: () {
            AppDialogs.showAddItemDialog(
              formKey: formKey,
              onSaveName: (value) => controller.purchaseItem.productName = value!,
              onSavePrice: (value) => controller.purchaseItem.price = value!,
              onSaveQuantity: (value) => controller.purchaseItem.quantity = value,
              onSaveButton: () {
                controller.saveItem();
              },
            );
          },
        ),
      ),
    );
  }
}
