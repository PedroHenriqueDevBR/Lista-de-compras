import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/core/colors_util.dart';

class CreateFamilyHeader extends StatelessWidget {
  GlobalKey<FormState> formKey;
  Family family;
  bool editIsActive;
  Function onSave;
  Function onChange;

  CreateFamilyHeader({
    Key? key,
    required this.formKey,
    required this.family,
    required this.editIsActive,
    required this.onSave,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              initialValue: family.name,
              readOnly: !editIsActive,
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == null || value.length == 0) {
                  return 'Digite algo para que possa ser salvo';
                }
                if (value.length > 20) {
                  return 'O limite é 20 caracteres';
                }
              },
              onChanged: (value) {
                onChange(value);
              },
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
              decoration: InputDecoration(
                enabledBorder: editIsActive
                    ? UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      )
                    : InputBorder.none,
                focusedBorder: editIsActive
                    ? UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      )
                    : InputBorder.none,
                errorStyle: TextStyle(color: Colors.white),
                errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor)),
                border: editIsActive ? UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)) : InputBorder.none,
              ),
            ),
          ),
          editIsActive
              ? Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            onSave();
                          }
                        },
                        child: Text('Salvar'),
                        style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
