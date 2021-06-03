import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/core/colors_util.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:asuka/asuka.dart' as asuka;

class ListFamiliesPage extends StatefulWidget {
  @override
  _ListFamiliesPageState createState() => _ListFamiliesPageState();
}

class _ListFamiliesPageState extends State<ListFamiliesPage> {
  RxNotifier<bool> dialVisible = RxNotifier<bool>(false);
  RxNotifier<int> selectedFamily = RxNotifier<int>(-1);
  RxList<int> pendingShoppingList = RxList<int>([1, 3]);

  RxList<Family> families = RxList<Family>([
    Family(id: 1, name: 'Eu Mesmo'),
    Family(id: 2, name: 'Familia Lima'),
  ]);

  RxList<ShoppingList> shoppingList = RxList<ShoppingList>([
    ShoppingList(id: 1, title: 'Teste 01', description: 'Apenas testes'),
    ShoppingList(id: 2, title: 'Teste 02', description: 'Apenas testes'),
  ]);

  void setDialVisible(bool value) {
    this.dialVisible.value = value;
  }

  void selectfamily(int value) {
    if (this.selectedFamily.value == value) {
      this.selectedFamily.value = -1;
    } else {
      this.selectedFamily.value = value;
    }
  }

  Widget bottomSheetOptions() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Para fechar arraste para baixo',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          title: Text('criar categoria'),
        ),
        Divider(),
        ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          title: Text('criar Lista de compras'),
        ),
      ],
    );
  }

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
            headerCard(size),
            familyList(size),
            shoppingListWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          asuka.showBottomSheet(
            (context) {
              return bottomSheetOptions();
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

  Widget headerCard(Size size) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: size.width,
        child: Text(
          'Voce possui 2 listas de compras pendentes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget familyList(Size size) {
    return Container(
      width: size.width,
      height: 60,
      child: ListView.builder(
        itemCount: families.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return familyItem(index, size);
        },
      ),
    );
  }

  Widget familyItem(int index, Size size) {
    return GestureDetector(
      onTap: () {
        selectfamily(index);
      },
      child: RxBuilder(
        builder: (_) => Card(
          color: selectedFamily.value == index ? Colors.indigo.shade200 : Colors.white,
          child: Container(
            width: 200,
            margin: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    families[index].name,
                  ),
                ),
                selectedFamily.value == index
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        visualDensity: VisualDensity.compact,
                        iconSize: 16.0,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shoppingListWidget() {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: shoppingList.length,
        itemBuilder: (_, index) {
          return shoppingListItem(shoppingList[index]);
        },
      ),
    );
  }

  Widget shoppingListItem(ShoppingList shoppingListItem) {
    return ListTile(
      leading: Icon(
        Icons.group_outlined,
      ),
      title: Text(
        shoppingListItem.title,
        style: TextStyle(),
      ),
      subtitle: Text(
        shoppingListItem.description != null ? shoppingListItem.description! : '',
        style: TextStyle(),
      ),
      selectedTileColor: AppColors.primaryColor,
    );
  }
}
