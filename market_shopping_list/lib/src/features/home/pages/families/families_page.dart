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
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            image: NetworkImage('https://images.pexels.com/photos/1724888/pexels-photo-1724888.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
          ),
        ),
        height: 130,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    family.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset.zero,
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Grupo pertencente a ${family.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
