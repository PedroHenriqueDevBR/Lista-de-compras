import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:market_shopping_list/src/core/colors_util.dart';
import 'package:market_shopping_list/src/features/create_family/create_family_controller.dart';
import 'package:market_shopping_list/src/features/create_family/widgets/create_family_header.dart';

class CreateFamilyPage extends StatefulWidget {
  Family? family;
  CreateFamilyPage({
    Key? key,
    this.family,
  }) : super(key: key);

  @override
  _CreateFamilyPageState createState() => _CreateFamilyPageState();
}

class _CreateFamilyPageState extends State<CreateFamilyPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CreateFamilyController controller = CreateFamilyController();

  @override
  void initState() {
    if (widget.family != null) controller.initFamilyData(widget.family!);
    controller.editIsActive.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar dados'),
        actions: [
          RxBuilder(
            builder: (context) => IconButton(
              onPressed: controller.toggleEditActive,
              icon: Icon(
                Icons.edit,
                color: controller.editIsActive.value ? AppColors.secondaryColor : Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.deleteFamily(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            RxBuilder(
              builder: (_) => CreateFamilyHeader(
                formKey: _formKey,
                family: controller.family.value,
                editIsActive: controller.editIsActive.value,
                onSave: controller.saveFamily,
              ),
            ),
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
                itemCount: controller.shoppingList.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  ShoppingList shoppingItem = controller.shoppingList[index];
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
      floatingActionButton: controller.family.value.id != null
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: Text('Lista de compras'),
              icon: Icon(Icons.add),
            )
          : null,
    );
  }
}
