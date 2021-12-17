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
import 'create_shopping_list_controller.dart';

class CreateShoppingListPage extends StatefulWidget {
  ShoppingList? shoppingList;
  CreateShoppingListPage({
    Key? key,
    this.shoppingList,
  }) : super(key: key);
  @override
  _CreateShoppingListPageState createState() => _CreateShoppingListPageState();
}

class _CreateShoppingListPageState extends State<CreateShoppingListPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreateShoppingListController controller = CreateShoppingListController(
    familyStorage: FamilyDAL(
      familySQL: FamilySQLite(),
      shoppingListSQL: ShoppingListSQLite(),
    ),
    shoppingStorage: ShoppingListDAL(
      shoppingListSQL: ShoppingListSQLite(),
      purchaseItemSQL: PurchaseItemSQLite(),
    ),
  );

  void initData() async {
    if (widget.shoppingList != null) {
      controller.initShoppingData(widget.shoppingList!);
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de compras'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.txtTitle,
                  decoration: InputDecoration(
                    hintText: 'Compras do mês',
                    labelText: 'Titulo',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    controller.shopping.value.title = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o título da lista de compras';
                    } else if (value.length > 30) {
                      return 'O limite para o título é de 30 caracteres';
                    }
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: controller.txtDescription,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Primeira compra do mês de junho',
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    controller.shopping.value.description = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite uma descrição, isso ajudará você no futuro';
                    }
                  },
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey.shade200, width: 1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: [
                      RxBuilder(
                        builder: (_) => Expanded(
                          child: DropdownButton<int>(
                            isExpanded: true,
                            value: controller.selectedFamilyID,
                            dropdownColor: Colors.white,
                            icon: Icon(Icons.keyboard_arrow_down),
                            underline: Container(),
                            items: controller.families.map((Family family) => DropdownMenuItem<int>(value: family.id!, child: Text(family.name))).toList(),
                            onChanged: (value) {
                              controller.setFamilyByID(value!);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          color: AppColors.primaryColorLight,
                          iconSize: 30,
                          onPressed: () {
                            controller.goToCreateFamilyPage(context);
                          },
                          icon: Icon(Icons.add)),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                RxBuilder(
                  builder: (context) => SwitchListTile(
                    title: Text('Concluir lista de compras'),
                    value: controller.doneOptionIsSelected.value,
                    onChanged: (value) {
                      controller.toggleDoneOption(value);
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        child: Text('Salvar', style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.saveShopping(context);
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
