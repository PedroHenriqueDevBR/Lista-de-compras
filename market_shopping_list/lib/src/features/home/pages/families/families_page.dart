import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/pages/families/components/families_components.dart';
import 'package:market_shopping_list/src/features/home/pages/families/families_controller.dart';
import 'package:market_shopping_list/src/shared/repositories/family_repository.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository.dart';

class FamiliesPage extends StatefulWidget {
  @override
  _FamiliesPageState createState() => _FamiliesPageState();
}

class _FamiliesPageState extends State<FamiliesPage> with FamiliesComponents {
  late FamiliesController _controller;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this._controller = FamiliesController(
      context: this.context,
      familyStorage: FamilyRepository(),
      personStorage: PersonRepository(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ValueListenableBuilder(
        valueListenable: _controller.loadDataFromDatabaseIsDone,
        builder: (context, bool value, child) {
          if (value) {
            return ValueListenableBuilder(
              valueListenable: _controller.families,
              builder: (_, __, ___) {
                if (_controller.families.value.length == 0) {
                  return Center(child: Text('Nenhuma família cadastrada'));
                } else {
                  return ListView.builder(
                    itemCount: _controller.families.value.length,
                    padding: EdgeInsets.all(8),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return familyCardItem(family: _controller.families.value[index]);
                    },
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: _controller.colorUtil.secondaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            builder: (modalContext) => Wrap(
              children: [
                Column(
                  children: [
                    ListTile(
                      title: Text('Criar família'),
                      onTap: () {
                        Navigator.pop(modalContext);
                        showCreateFamilyDialog();
                      },
                    ),
                    ListTile(
                      title: Text('Entrar em uma família'),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showCreateFamilyDialog() {
    asuka.showDialog(
      builder: (dialogContext) => AlertDialog(
        content: Container(
          child: Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome da família',
                hintText: 'Ex: Lima',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
              },
              onSaved: (familyName) => _controller.familyToSave.name = familyName!,
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
          TextButton(
            child: Text('Salvar'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _controller.createFamily();
                Navigator.pop(dialogContext);
              }
            },
          ),
        ],
      ),
    );
  }
}
