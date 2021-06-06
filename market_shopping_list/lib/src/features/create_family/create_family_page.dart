import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/dal/family_dal.dart';
import 'package:market_shopping_list/src/shared/dal/shopping_list_dal.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/family_sqlite_sql.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/purchase_item_sqlite_sql.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/shopping_list_sqlite_sql.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:market_shopping_list/src/core/colors_util.dart';
import 'package:market_shopping_list/src/features/create_family/create_family_controller.dart';
import 'package:market_shopping_list/src/features/create_family/widgets/create_family_header.dart';
import 'package:asuka/asuka.dart' as asuka;

class CreateFamilyPage extends StatefulWidget {
  Family? family;
  CreateFamilyPage({
    Key? key,
    this.family,
  }) : super(key: key);

  @override
  _CreateFamilyPageState createState() => _CreateFamilyPageState();
}

class _CreateFamilyPageState extends State<CreateFamilyPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreateFamilyController controller = CreateFamilyController(
    familyStorage: FamilyDAL(
      familySQL: FamilySQLite(),
      shoppingListSQL: ShoppingListSQLite(),
    ),
    shoppingStorage: ShoppingListDAL(
      shoppingListSQL: ShoppingListSQLite(),
      purchaseItemSQL: PurchaseItemSQLite(),
    ),
  );

  @override
  void initState() {
    if (widget.family != null) {
      controller.initFamilyData(widget.family!);
    }
    controller.editIsActive.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar dados'),
        actions: [
          RxBuilder(
            builder: (context) => IconButton(
              onPressed: controller.toggleEditActive,
              icon: Icon(
                Icons.edit,
                color: controller.editIsActive.value ? AppColors.secondaryColor : Colors.white,
              ),
            ),
          ),
          controller.family.value.id == null
              ? Container()
              : IconButton(
                  onPressed: () {
                    if (controller.family.value.id == null) {
                      asuka.showSnackBar(AsukaSnackbar.info('Não há dados para deletar'));
                    } else {
                      asuka.showDialog(
                        builder: (dialogContext) => AlertDialog(
                          title: Text('Deletar "${controller.family.value.name}"'),
                          content: Container(
                            child: Text('Atenção, você realmente deseja deletar a categoria?'),
                          ),
                          actions: [
                            TextButton(
                              child: Text('Não'),
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                            ),
                            TextButton(
                              child: Text('Sim'),
                              onPressed: () async {
                                await controller.deleteFamilyFromDatabase().then((_) => Navigator.pop(context));
                                Navigator.pop(dialogContext);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            RxBuilder(
              builder: (_) => CreateFamilyHeader(
                formKey: _formKey,
                family: controller.family.value,
                editIsActive: controller.editIsActive.value,
                onSave: controller.saveFamily,
                onChange: controller.onChangeTextInput,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Listas de compras da categoria',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Divider(),
            Expanded(
              child: RxBuilder(
                builder: (_) => ListView.separated(
                  itemCount: controller.shoppingList.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    ShoppingList shoppingItem = controller.shoppingList[index];
                    return ListTile(
                      leading: Icon(Icons.shopping_cart_outlined),
                      trailing: shoppingItem.isDone ? Icon(Icons.check) : null,
                      title: Text(shoppingItem.title),
                      subtitle: Text(shoppingItem.description != null ? shoppingItem.description! : ''),
                      onTap: () {
                        controller.goToShowShoppingList(context, shoppingItem);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: controller.family.value.id != null
          ? FloatingActionButton.extended(
              onPressed: () {
                controller.goToCreateShoppingList(context);
              },
              label: Text('Lista de compras'),
              icon: Icon(Icons.add),
            )
          : null,
    );
  }
}
