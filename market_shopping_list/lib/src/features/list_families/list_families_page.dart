import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/create_family/create_family_page.dart';
import 'package:market_shopping_list/src/features/list_families/list_families_controller.dart';
import 'package:market_shopping_list/src/features/list_families/widgets/bottom_sheet_options.dart';
import 'package:market_shopping_list/src/features/list_families/widgets/family_item.dart';
import 'package:market_shopping_list/src/features/list_families/widgets/list_families_header.dart';
import 'package:market_shopping_list/src/features/list_families/widgets/shopping_list_item.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:market_shopping_list/src/shared/dal/family_dal.dart';
import 'package:market_shopping_list/src/shared/dal/shopping_list_dal.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/family_sqlite_sql.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/purchase_item_sqlite_sql.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/shopping_list_sqlite_sql.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ListFamiliesPage extends StatefulWidget {
  @override
  _ListFamiliesPageState createState() => _ListFamiliesPageState();
}

class _ListFamiliesPageState extends State<ListFamiliesPage> {
  ListFamiliesController controller = ListFamiliesController(
    familyStorage: FamilyDAL(familySQL: FamilySQLite(), shoppingListSQL: ShoppingListSQLite()),
    shoppingStorage: ShoppingListDAL(shoppingListSQL: ShoppingListSQLite(), purchaseItemSQL: PurchaseItemSQLite()),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de compras'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListFamiliesHeader(size: size),
            RxBuilder(
              builder: (_) => familyList(
                size: size,
                families: controller.families,
                selectedFamily: controller.selectedFamily.value,
              ),
            ),
            shoppingListWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showBottomDialog();
        },
        label: Text('Adicionar'),
        icon: Icon(Icons.add),
      ),
    );
  }

  void showBottomDialog() {
    asuka.showBottomSheet(
      (context) {
        return BottomSheetOptions(
          familyFunction: () {
            controller.goToCreateFamilyPage(context);
          },
          shoppingListFunction: () {
            controller.goToCreateShoppingListPage(context);
          },
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 4.0,
    );
  }

  Widget familyList({required Size size, required List<Family> families, required int selectedFamily}) {
    return Container(
      width: size.width,
      height: 60,
      child: ListView.builder(
        itemCount: families.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return RxBuilder(
            builder: (_) => FamilyItem(
              size: size,
              family: families[index],
              onClick: () {
                controller.selectfamily(index);
              },
              onEditClick: () {
                controller.goToCreateFamilyPage(context, family: controller.families[index]);
              },
              selected: selectedFamily == index,
            ),
          );
        },
      ),
    );
  }

  Widget shoppingListWidget() {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.shoppingList.length,
        itemBuilder: (_, index) {
          return ShoppinglistItem(shoppingList: controller.shoppingList[index]);
        },
      ),
    );
  }
}
