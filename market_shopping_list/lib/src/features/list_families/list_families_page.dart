import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../core/colors_util.dart';
import '../../shared/dal/family_dal.dart';
import '../../shared/dal/shopping_list_dal.dart';
import '../../shared/dal/sqlite_sql/family_sqlite_sql.dart';
import '../../shared/dal/sqlite_sql/purchase_item_sqlite_sql.dart';
import '../../shared/dal/sqlite_sql/shopping_list_sqlite_sql.dart';
import '../../shared/models/family.dart';
import '../../shared/models/shopping_list.dart';
import 'list_families_controller.dart';
import 'widgets/family_item.dart';
import 'widgets/list_families_header.dart';
import 'widgets/shopping_list_item.dart';

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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              RxBuilder(
                builder: (_) => ListFamiliesHeader(
                  size: size,
                  pendingCount: controller.pendingShoppingListCount.value,
                  child: RxBuilder(
                    builder: (_) => familyList(
                      size: size,
                      families: controller.families,
                      selectedFamily: controller.selectedFamily.value,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              shoppingListWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget familyList({required Size size, required List<Family> families, required int selectedFamily}) {
    return Container(
      width: size.width,
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => controller.goToCreateFamilyPage(context),
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 26,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            controller.families.length != 0
                ? ListView.builder(
                    itemCount: families.length,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Nova categoria',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget shoppingListWidget() {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.add,
              size: 24.0,
              color: AppColors.primaryColor,
            ),
            title: Text('Nova lista de compras'),
            onTap: () => controller.goToCreateShoppingListPage(context),
          ),
          Divider(),
          RxBuilder(
            builder: (context) {
              if (controller.shoppingList.length != 0) {
                return ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.shoppingList.length,
                  itemBuilder: (_, index) {
                    ShoppingList currentShopping = controller.shoppingList[index];
                    return ShoppinglistItem(
                      shoppingList: currentShopping,
                      onTap: () {
                        controller.goToShowShoppingListPage(context: context, shopping: currentShopping);
                      },
                    );
                  },
                );
              }
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list_alt_outlined,
                        size: 50,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'nenhuma lista de compras salva no momento',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
