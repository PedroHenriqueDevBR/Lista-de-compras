import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/show_family/show_family_contoller.dart';
import 'package:market_shopping_list/src/shared/components/family_card_component.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class ShowFamilyPage extends StatefulWidget {
  Family family;

  ShowFamilyPage({required this.family});

  @override
  _ShowFamilyPageState createState() => _ShowFamilyPageState();
}

class _ShowFamilyPageState extends State<ShowFamilyPage> {
  late ShowFamilyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ShowFamilyController(family: widget.family);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.family.value.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              FamilyCardComponent(family: _controller.family.value),
              SizedBox(height: 16.0),
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 4.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Busca',
                          hintText: 'Digite o Titulo',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        SizedBox(width: 10.0),
                        IconButton(
                          icon: Icon(Icons.add_shopping_cart_outlined),
                          onPressed: () {
                            _controller.goToCreatePurchaseItemPage(context);
                          },
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.filter_list_outlined),
                          onSelected: (value) {
                            print(value);
                          },
                          itemBuilder: (context) => <PopupMenuItem<String>>[
                            PopupMenuItem(
                              child: Text('Todos'),
                              value: 'todos',
                            ),
                            PopupMenuItem(
                              child: Text('Pendentes'),
                              value: 'pendentes',
                            ),
                            PopupMenuItem(
                              child: Text('Conluídos'),
                              value: 'concluidos',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: _controller.isLoadingShopingList,
                builder: (_, bool value, ___) {
                  if (value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (_controller.shoppingListItens.value.length == 0) {
                      return Container(
                        child: Text('Nenhuma lista de compras cadastrada'),
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _controller.shoppingListItens.value.length,
                        itemBuilder: (context, index) {
                          ShoppingList shoppingList = _controller.shoppingListItens.value[index];
                          return Card(
                            borderOnForeground: true,
                            elevation: 0,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: shoppingList.is_done ? Colors.green : Colors.red.shade600,
                                child: shoppingList.is_done
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                              ),
                              title: Text(shoppingList.title),
                              subtitle: Text(shoppingList.description),
                              onTap: () {
                                _controller.goToCreatePurchaseItemPage(context, shoppingList: shoppingList);
                              },
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
