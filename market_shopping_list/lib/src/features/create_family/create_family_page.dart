import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/core/colors_util.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CreateFamilyPage extends StatefulWidget {
  @override
  _CreateFamilyPageState createState() => _CreateFamilyPageState();
}

class _CreateFamilyPageState extends State<CreateFamilyPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxNotifier<bool> editIsActive = RxNotifier<bool>(false);
  RxList<ShoppingList> shoppingList = RxList<ShoppingList>([
    ShoppingList(id: 1, title: 'Teste 01', description: 'Apenas testes'),
    ShoppingList(id: 2, title: 'Teste 02', description: 'Apenas testes'),
    ShoppingList(id: 3, title: 'Teste 03', description: 'Apenas testes'),
    ShoppingList(id: 4, title: 'Teste 04', description: 'Apenas testes'),
    ShoppingList(id: 5, title: 'Teste 05', description: 'Apenas testes'),
    ShoppingList(id: 6, title: 'Teste 06', description: 'Apenas testes'),
  ]);
  RxNotifier<Family> family = RxNotifier<Family>(Family.withNoData());

  toggleEditActive() {
    this.editIsActive.value = !this.editIsActive.value;
  }

  void saveFamily() {
    family.value.id = 1;
    AsukaSnackbar.info('Dados salvos');
  }

  @override
  void initState() {
    family.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fámilia'),
        actions: [
          RxBuilder(
            builder: (context) => IconButton(
              onPressed: toggleEditActive,
              icon: Icon(
                Icons.edit,
                color: editIsActive.value ? AppColors.secondaryColor : Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            familyHeader(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Listas de compras da categoria',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: shoppingList.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  ShoppingList shoppingItem = shoppingList[index];
                  return ListTile(
                    leading: Icon(Icons.shopping_cart_outlined),
                    title: Text(shoppingItem.title),
                    subtitle: Text(shoppingItem.description != null ? shoppingItem.description! : ''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: family.value.id != null
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: Text('Lista de compras'),
              icon: Icon(Icons.add),
            )
          : null,
    );
  }

  Widget familyHeader() {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
      child: RxBuilder(
        builder: (_) => Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                initialValue: family.value.name,
                readOnly: !editIsActive.value,
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Digite algo para que possa ser salvo';
                  }
                  if (value.length > 20) {
                    return 'O limite é 20 caracteres';
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
                decoration: InputDecoration(
                  enabledBorder: editIsActive.value
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        )
                      : InputBorder.none,
                  focusedBorder: editIsActive.value
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        )
                      : InputBorder.none,
                  errorStyle: TextStyle(color: Colors.white),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor)),
                  border: editIsActive.value ? UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)) : InputBorder.none,
                ),
              ),
            ),
            editIsActive.value
                ? Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              saveFamily();
                            }
                          },
                          child: Text('Salvar'),
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
