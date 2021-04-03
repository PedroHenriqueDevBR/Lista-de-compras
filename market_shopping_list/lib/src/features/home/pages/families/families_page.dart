import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/pages/families/components/families_components.dart';
import 'package:market_shopping_list/src/features/home/pages/families/families_controller.dart';

class FamiliesPage extends StatefulWidget {
  @override
  _FamiliesPageState createState() => _FamiliesPageState();
}

class _FamiliesPageState extends State<FamiliesPage> with FamiliesComponents {
  FamiliesController _controller = FamiliesController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _controller.families.length,
      padding: EdgeInsets.all(8),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return familyCardItem(family: _controller.families[index]);
      },
    );
  }
}
