import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/create_family/create_family_page.dart';
import 'package:market_shopping_list/src/features/list_families/list_families_controller.dart';
import 'package:market_shopping_list/src/features/list_families/widgets/bottom_sheet_options.dart';
import 'package:market_shopping_list/src/features/list_families/widgets/family_item.dart';
import 'package:market_shopping_list/src/features/list_families/widgets/list_families_header.dart';
import 'package:market_shopping_list/src/features/list_families/widgets/shopping_list_item.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:rx_notifier/rx_notifier.dart';

class ListFamiliesPage extends StatefulWidget {
  @override
  _ListFamiliesPageState createState() => _ListFamiliesPageState();
}

class _ListFamiliesPageState extends State<ListFamiliesPage> {
  ListFamiliesController controller = ListFamiliesController();

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
            familyList(size),
            shoppingListWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          asuka.showBottomSheet(
            (context) {
              return BottomSheetOptions(
                familyFunction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateFamilyPage(),
                    ),
                  );
                },
                shoppingListFunction: () {
                  print('Deve ser implementada');
                },
              );
            },
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              side: BorderSide(color: Colors.grey.shade200),
            ),
          );
        },
        label: Text('Adicionar'),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget familyList(Size size) {
    return Container(
      width: size.width,
      height: 60,
      child: ListView.builder(
        itemCount: controller.families.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return RxBuilder(
            builder: (_) => FamilyItem(
              size: size,
              family: controller.families[index],
              onClick: () {
                controller.selectfamily(index);
              },
              selected: controller.selectedFamily.value == index,
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
