import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class FamilyCardComponent extends StatelessWidget {
  Family family;
  ImageReference _imageReference = ImageReference();

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
                  image: AssetImage(_imageReference.purpleSky),
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
