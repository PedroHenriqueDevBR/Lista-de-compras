import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListPurchaseItemPage extends StatefulWidget {
  @override
  _ListPurchaseItemPageState createState() => _ListPurchaseItemPageState();
}

class _ListPurchaseItemPageState extends State<ListPurchaseItemPage> {
  ValueNotifier<bool> isDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> selectIsActive = ValueNotifier<bool>(false);

  String formatDate({DateTime? datetime}) {
    if (datetime == null) {
      datetime = DateTime.now();
    }
    return '${datetime.day}/${datetime.month}/${datetime.year} às ${datetime.hour}:${datetime.minute}';
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
        ),
      ),
    );
  }
}
