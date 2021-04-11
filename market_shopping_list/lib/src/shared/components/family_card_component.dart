import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';

class FamilyCardComponent extends StatelessWidget {
  Family family;

  FamilyCardComponent({required this.family});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      elevation: 2.0,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
                image: DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/34090/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity.standard,
              leading: Icon(Icons.group_outlined),
              title: Text(
                family.name,
              ),
              subtitle: Text(
                'Grupo pertencente a ${family.name}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
