import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';

class ListPurchaseItemComponents {
  Widget defaultButton({
    required String title,
    required Function action,
    Icon? icon,
    required BuildContext context,
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

  Widget inputTitle() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Título',
        hintText: 'Compras do mês',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget inputDescription() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Descrição',
        hintText: 'Breve descrição da lista de compras',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget checkboxShoppingListIsDone(bool value, Function action) {
    return CheckboxListTile(
      value: value,
      title: Text('Finalizar lista de compras'),
      onChanged: (value) {
        action(value);
      },
    );
  }

  Widget inputProductName({required String initialValue}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: 'Nome do produto',
        hintText: 'Ex: Arroz',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget checkboxPurchasedProduct({required bool value, required Function onChange}) {
    return CheckboxListTile(
      value: value,
      title: Text('Produto comprado'),
      onChanged: (data) {
        onChange(data);
      },
    );
  }

  Widget formBottomActionsContainer({
    required Function cancelAction,
    required Function doneAction,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            cancelAction();
          },
        ),
        TextButton(
          child: Text('Adicionar'),
          onPressed: () {
            doneAction;
          },
        ),
      ],
    );
  }

  Widget createAtText(String date) {
    return Text(
      'Data da criação: ${date}',
      textAlign: TextAlign.left,
    );
  }

  Widget purchaseItemCard({required PurchaseItem purchaseItem, required Function onClick}) {
    return Card(
      elevation: 0.0,
      child: ListTile(
        title: Text('${purchaseItem.quantity} X ${purchaseItem.productName}'),
        subtitle: purchaseItem.purchasedBy != null ? Text('Preço unitário: R\$ ${purchaseItem.purchasePrice} | Total: R\$ ${purchaseItem.purchaseTotal}') : Text('Pendente'),
        trailing: purchaseItem.purchasedBy != null ? Icon(Icons.done) : Icon(Icons.close),
        onTap: () {
          onClick();
        },
      ),
    );
  }
}
