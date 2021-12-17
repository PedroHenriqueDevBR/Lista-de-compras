import 'package:flutter/material.dart';

import '../../../core/colors_util.dart';
import 'dialogs_widget.dart';

class HeaderWidget extends StatelessWidget {
  String title;
  String description;
  bool isDone;
  String creationDate;
  String total;
  Function doneFunction;
  Function goToEditShoppingListPageFunction;
  Function deleteShoppingListFunction;

  HeaderWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.isDone,
    required this.creationDate,
    required this.total,
    required this.doneFunction,
    required this.goToEditShoppingListPageFunction,
    required this.deleteShoppingListFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey.shade200,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: AppColors.primaryColor.withAlpha(50),
                avatar: CircleAvatar(
                  backgroundColor: isDone ? Colors.lightGreen : AppColors.primaryColorLight,
                ),
                label: Text(
                  '${isDone ? "Concluída" : "Andamento"}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(width: 6.0),
              Chip(
                backgroundColor: AppColors.primaryColor.withAlpha(50),
                label: Text(
                  'Criada em ${creationDate}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Chip(
            backgroundColor: Colors.white,
            label: Text(
              'Total: R\$ ${total}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                fontSize: 16.0,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                icon: Icon(Icons.edit_outlined, color: Colors.white),
                label: Text('Editar dados', style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white, width: 2)),
                onPressed: () {
                  goToEditShoppingListPageFunction();
                },
              ),
              SizedBox(width: 8.0),
              OutlinedButton.icon(
                icon: Icon(Icons.delete_outline, color: Colors.white),
                label: Text('lista de compras', style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white, width: 2)),
                onPressed: () {
                  AppDialogs.confirmDeleteList(
                      confirmFunction: () async {
                        await deleteShoppingListFunction();
                      },
                      context: context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
