import 'package:flutter/material.dart';

class BottomSheetOptions extends StatelessWidget {
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
        ),
        Divider(),
        ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          title: Text('criar Lista de compras'),
        ),
      ],
    );
  }
}
