import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/pages/families/families_controller.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';

class FamiliesPage extends StatefulWidget {
  @override
  _FamiliesPageState createState() => _FamiliesPageState();
}

class _FamiliesPageState extends State<FamiliesPage> {
  FamiliesController _controller = FamiliesController();

  Widget _familyCardItem(Family family) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.blueGrey[50],
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://images.pexels.com/photos/4194857/pexels-photo-4194857.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 8.0,
              decoration: BoxDecoration(
                color: _controller.colorUtil.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      family.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Grupo pertencente a ${family.name}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _controller.families.length,
      padding: EdgeInsets.all(8),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _familyCardItem(_controller.families[index]);
      },
    );
  }
}
