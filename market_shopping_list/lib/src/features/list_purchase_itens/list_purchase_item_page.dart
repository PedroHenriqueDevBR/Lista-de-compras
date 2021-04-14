import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/list_purchase_itens/list_purchase_item_components.dart';
import 'package:market_shopping_list/src/features/list_purchase_itens/list_purchase_item_controller.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class ListPurchaseItemPage extends StatefulWidget {
  Family family;
  ShoppingList? shoppingList;

  ListPurchaseItemPage({required this.family, this.shoppingList});

  @override
  _ListPurchaseItemPageState createState() => _ListPurchaseItemPageState();
}

class _ListPurchaseItemPageState extends State<ListPurchaseItemPage>
    with ListPurchaseItemComponents {
  late ListPurchaseItemController _controller;
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = ListPurchaseItemController(
      family: widget.family,
      shoppingListArgument: widget.shoppingList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de compras'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            Divider(),
            Text('Preenha os dados abaixo para criar a lista de compras'),
            Divider(),
            Form(
              key: _formState,
              child: Column(
                children: [
                  inputTitle(
                    initialValue: _controller.currentShoppingList.value.title,
                    onChange: (value) =>
                        _controller.currentShoppingList.value.title = value,
                    onSaved: (newValue) =>
                        _controller.currentShoppingList.value.title = newValue,
                  ),
                  SizedBox(height: 8.0),
                  inputDescription(
                    initialValue: _controller.currentShoppingList.value.description,
                    onChange: (value) =>
                        _controller.currentShoppingList.value.description = value,
                    onSaved: (newValue) =>
                        _controller.currentShoppingList.value.description = newValue,
                  ),
                  SizedBox(height: 8.0),
                  ValueListenableBuilder(
                    valueListenable: _controller.checkboxShoppingListIsDone,
                    builder: (_, bool value, ___) {
                      _controller.currentShoppingList.value.is_done = value;
                      return checkboxShoppingListIsDone(
                          value, _controller.setIsDone);
                    },
                  ),
                  SizedBox(height: 8.0),
                  createAtText(_controller.formatDate()),
                ],
              ),
            ),
            Divider(),
            ValueListenableBuilder(
              valueListenable: _controller.isSavedPurchaseItem,
              builder: (_, bool value, ___) {
                return Row(
                  children: [
                    Expanded(
                      child: defaultButton(
                        title: 'Salvar',
                        action: () {
                          if (_formState.currentState!.validate()) {
                            _formState.currentState!.save();
                            _controller.saveData();
                          }
                        },
                        context: context,
                      ),
                    ),
                    value
                        ? Expanded(
                            child: defaultButton(
                              title: 'Adicionar item',
                              action: showItemForm,
                              icon: Icon(Icons.add, color: Colors.white),
                              context: context,
                            ),
                          )
                        : Container(),
                  ],
                );
              },
            ),
            Divider(),
            ValueListenableBuilder(
              valueListenable: _controller.isSavedPurchaseItem,
              builder: (_, bool value, ___) {
                if (value) {
                  return Wrap(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _controller.purchaseTotal,
                        builder: (_, value, ___) => ListTile(
                          title: Text('Total: R\$ $value'),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListView.builder(
                        itemCount: _controller.purchaseItens.value.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => purchaseItemCard(
                            purchaseItem:
                                _controller.purchaseItens.value[index],
                            onClick: () {}),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void showItemForm({PurchaseItem? purchaseItem}) {
    if (purchaseItem != null) {
      _controller.purchaseItemAmount.value = purchaseItem.quantity;
      if (purchaseItem.purchasedBy != null) {
        _controller.checkboxPurchasedProduct.value = true;
      } else {
        _controller.checkboxPurchasedProduct.value = true;
      }
    } else {
      _controller.purchaseItemAmount.value = 0;
    }
    asuka.showDialog(
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Item'),
          content: Form(
            child: Wrap(
              children: [
                inputProductName(
                    initialValue:
                        purchaseItem != null ? purchaseItem.productName : ''),
                Divider(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        _controller.changeAmount(-1);
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _controller.purchaseItemAmount,
                      builder: (_, value, __) => Text(value.toString()),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _controller.changeAmount(1);
                      },
                    ),
                  ],
                ),
                Divider(),
                ValueListenableBuilder(
                  valueListenable: _controller.checkboxPurchasedProduct,
                  builder: (_, value, ___) {
                    return checkboxPurchasedProduct(
                      value: _controller.checkboxPurchasedProduct.value,
                      onChange: (data) {
                        _controller.checkboxPurchasedProduct.value = data!;
                        _controller.checkboxPurchasedProduct.notifyListeners();
                      },
                    );
                  },
                ),
                formBottomActionsContainer(
                  cancelAction: () {
                    Navigator.pop(dialogContext);
                  },
                  doneAction: () {
                    Navigator.pop(dialogContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
