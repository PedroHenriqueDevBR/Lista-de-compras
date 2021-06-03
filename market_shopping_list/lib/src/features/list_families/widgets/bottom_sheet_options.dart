import 'package:flutter/material.dart';

class BottomSheetOptions extends StatelessWidget {
  Function familyFunction;
  Function shoppingListFunction;

  BottomSheetOptions({
    Key? key,
    required this.familyFunction,
    required this.shoppingListFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onTap: () {
            familyFunction();
          },
        ),
        Divider(),
        ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          title: Text('criar Lista de compras'),
          onTap: () {
            shoppingListFunction();
          },
        ),
      ],
    );
  }
}
