import 'package:flutter/material.dart';
import '../../../core/colors_util.dart';

import '../../../shared/models/family.dart';

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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: selected ? Colors.white : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white, width: 2.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 4.0),
            Text(
              family.name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.primaryColor : Colors.white,
              ),
            ),
            SizedBox(width: 4.0),
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
    );
  }
}
