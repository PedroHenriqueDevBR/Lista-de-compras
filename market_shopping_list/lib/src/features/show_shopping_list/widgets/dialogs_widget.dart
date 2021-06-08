import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:market_shopping_list/src/core/colors_util.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';

class AppDialogs {
  static bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  static void showAddItemDialog({
    required GlobalKey<FormState> formKey,
    required Function onSaveName,
    required Function onSavePrice,
    required Function onSaveQuantity,
    required Function onSaveButton,
    PurchaseItem? item,
  }) {
    asuka.showDialog(
      builder: (dialogContext) => AlertDialog(
        title: Text('Item'),
        content: Wrap(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: item != null ? item.productName : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ex: Arrox',
                      labelText: 'Produto',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite o nome do produto';
                      } else if (value.length >= 20) {
                        return 'O limite é 20 caracteres';
                      }
                    },
                    onSaved: (value) {
                      onSaveName(value);
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    initialValue: item != null ? item.price.toString() : null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ex: 0.00',
                      labelText: 'preço',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (value.indexOf(',') != -1) {
                        return 'vírgulas não são válidas';
                      } else if (!isNumeric(value)) {
                        return 'O valor não é válido';
                      }
                    },
                    onSaved: (value) {
                      onSavePrice(double.parse(value!.replaceAll(',', '.')));
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    initialValue: item != null ? item.quantity.toString() : null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '0',
                      labelText: 'Quantidade',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (value.indexOf(',') != -1) {
                        return 'vírgulas não são válidas';
                      } else if (!isNumeric(value)) {
                        return 'O valor não é válido';
                      }
                    },
                    onSaved: (value) {
                      double doubleValue = double.parse(value!.replaceAll(',', '.'));
                      onSaveQuantity(doubleValue.toInt());
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text(
                            'Salvar',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(backgroundColor: AppColors.primaryColor),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              onSaveButton();
                              Navigator.pop(dialogContext);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void confirmRemoveItem({
    required PurchaseItem item,
    required Function confirmFunction,
  }) {
    asuka.showDialog(
      builder: (dialogContext) => AlertDialog(
        title: Text('atenção'),
        content: Text('Você realmente deseja remover o item da lista de compras?'),
        actions: [
          TextButton(
            child: Text('Não'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
          TextButton(
            child: Text('Sim'),
            onPressed: () {
              confirmFunction();
              Navigator.pop(dialogContext);
            },
          ),
        ],
      ),
    );
  }

  static void confirmDeleteList({required confirmFunction, required BuildContext context}) {
    asuka.showDialog(
      builder: (dialogContext) => AlertDialog(
        title: Text('atenção'),
        content: Text('Você realmente deseja deletar a lista de compras atual?'),
        actions: [
          TextButton(
            child: Text('Não'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
          TextButton(
            child: Text('Sim'),
            onPressed: () async {
              await confirmFunction();
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
