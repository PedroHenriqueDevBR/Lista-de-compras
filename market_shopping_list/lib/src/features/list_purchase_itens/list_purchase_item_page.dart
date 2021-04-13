import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';

class ListPurchaseItemPage extends StatefulWidget {
  @override
  _ListPurchaseItemPageState createState() => _ListPurchaseItemPageState();
}

class _ListPurchaseItemPageState extends State<ListPurchaseItemPage> {
  ValueNotifier<bool> isDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> selectIsActive = ValueNotifier<bool>(false);
  ValueNotifier<bool> purchasedProduct = ValueNotifier<bool>(false);
  ValueNotifier<bool> isSavedPurchaseItem = ValueNotifier<bool>(false);
  ValueNotifier<int> amount = ValueNotifier<int>(0);

  String formatDate({DateTime? datetime}) {
    if (datetime == null) {
      datetime = DateTime.now();
    }
    return '${datetime.day}/${datetime.month}/${datetime.year} às ${datetime.hour}:${datetime.minute}';
  }

  void changeAmount(int value) {
    amount.value += value;
  }

  void savePurchaseList() {
    isSavedPurchaseItem.value = true;
    asuka.AsukaSnackbar.message('Lista de compras registrada com sucesso!');
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
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Título',
                      hintText: 'Compras do mês',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      hintText: 'Breve descrição da lista de compras',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ValueListenableBuilder(
                    valueListenable: isDone,
                    builder: (_, value, ___) {
                      return CheckboxListTile(
                        value: isDone.value,
                        title: Text('Finalizar lista de compras'),
                        onChanged: (data) {
                          isDone.value = data!;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Data da criação: ${formatDate()}',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Divider(),
            ValueListenableBuilder(
              valueListenable: isSavedPurchaseItem,
              builder: (_, bool value, ___) {
                if (value) {
                  return defaultButton(
                    title: 'Adicionar item',
                    action: showItemForm,
                    icon: Icon(Icons.add, color: Colors.white),
                  );
                } else {
                  return defaultButton(
                    title: 'Salvar',
                    action: savePurchaseList,
                  );
                }
              },
            ),
            Divider(),
            ValueListenableBuilder(
              valueListenable: isSavedPurchaseItem,
              builder: (_, bool value, ___) {
                if (value) {
                  return Wrap(
                    children: [
                      Text('Itens'),
                      SizedBox(height: 8.0),
                      ListView.builder(
                        itemCount: 8,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Card(
                          elevation: 0.0,
                          child: ListTile(
                            title: Text('3 X Arroz 5Kg'),
                            subtitle: Text('Comprado por: Pedro Henrique'),
                            trailing: Icon(Icons.done),
                          ),
                        ),
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

  Widget defaultButton({
    required String title,
    required Function action,
    Icon? icon,
  }) {
    return Card(
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
          textAlign: icon != null ? TextAlign.left : TextAlign.center,
        ),
        trailing: icon,
        onTap: () {
          action();
        },
      ),
    );
  }

  void showItemForm({PurchaseItem? purchaseItem}) {
    if (purchaseItem != null) {
      amount.value = purchaseItem.quantity;
      if (purchaseItem.purchasedBy != null) {
        purchasedProduct.value = true;
      } else {
        purchasedProduct.value = true;
      }
    } else {
      amount.value = 0;
    }
    asuka.showDialog(
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Item'),
          content: Form(
            child: Wrap(
              children: [
                TextFormField(
                  initialValue: purchaseItem != null ? purchaseItem.productName : '',
                  decoration: InputDecoration(
                    labelText: 'Nome do produto',
                    hintText: 'Ex: Arroz',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        changeAmount(-1);
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: amount,
                      builder: (_, value, __) => Text(value.toString()),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        changeAmount(1);
                      },
                    ),
                  ],
                ),
                Divider(),
                ValueListenableBuilder(
                  valueListenable: purchasedProduct,
                  builder: (_, value, ___) {
                    return CheckboxListTile(
                      value: purchasedProduct.value,
                      title: Text('Produto comprado'),
                      onChanged: (data) {
                        purchasedProduct.value = data!;
                        purchasedProduct.notifyListeners();
                      },
                    );
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                    ),
                    TextButton(
                      child: Text('Adicionar'),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
