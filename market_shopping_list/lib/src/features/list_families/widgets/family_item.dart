import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'package:market_shopping_list/src/shared/models/family.dart';

class FamilyItem extends StatelessWidget {
  Size size;
  Family family;
  Function onClick;
  Function onEditClick;
  bool selected;

  FamilyItem({
    Key? key,
    required this.size,
    required this.family,
    required this.onClick,
    required this.onEditClick,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onClick();
      },
      child: Card(
        color: selected ? Colors.indigo.shade200 : Colors.white,
        child: Container(
          width: 200,
          margin: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  family.name,
                ),
              ),
              selected
                  ? IconButton(
                      onPressed: () {
                        onEditClick();
                      },
                      icon: Icon(Icons.edit),
                      visualDensity: VisualDensity.compact,
                      iconSize: 16.0,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
