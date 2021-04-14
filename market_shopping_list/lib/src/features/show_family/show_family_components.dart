import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class ShowFamilyCompoenents {
  Widget searchInput({required Function onChange, bool isEnable = null ?? false}) {
    return TextFormField(
      enabled: isEnable,
      onChanged: (value){
        onChange(value);
      },
      decoration: InputDecoration(
        labelText: 'Busca',
        hintText: 'Digite o Titulo',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buttonOptionsMenu({required onSelected}) {
    return PopupMenuButton(
      icon: Icon(Icons.filter_list_outlined),
      onSelected: (value) {
        onSelected(value);
      },
      itemBuilder: (context) => <PopupMenuItem<int>>[
        PopupMenuItem(
          child: Text('Todos'),
          value: 0,
        ),
        PopupMenuItem(
          child: Text('Pendentes'),
          value: 1,
        ),
        PopupMenuItem(
          child: Text('Conluídos'),
          value: 2,
        ),
      ],
    );
  }

  Widget cardShoppingListItem({required ShoppingList shoppingList, required Function onTap,}) {
    return Card(
      borderOnForeground: true,
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: shoppingList.is_done
              ? Colors.green
              : Colors.red.shade600,
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
        onTap: (){onTap();},
      ),
    );
  }
}