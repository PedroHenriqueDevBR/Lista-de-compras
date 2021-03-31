import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class HomeComponents {
  ImageReference _imageReference = ImageReference();
  ColorUtil _colorUtil = ColorUtil();

  Widget drawerHead() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(
            _imageReference.logo,
            width: 40,
          ),
          SizedBox(width: 16),
          Text('Lista de compras'),
        ],
      ),
    );
  }

  Widget drawerItemConfigure({
    required IconData icon,
    required String text,
    required Function action,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        action();
      },
    );
  }

  Widget drawerFamilyItem({
    required Family family,
  }) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          _getFamilyNameFirstLetters(family.name),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: _colorUtil.secondaryColor,
      ),
      title: Text(family.name),
    );
  }

  List<Widget> getFamilieListForDrawer({required List<Family> families}) {
    List<Widget> familieList = [];
    for (Family family in families) {
      familieList.add(drawerFamilyItem(family: family));
    }
    return familieList;
  }

  String _getFamilyNameFirstLetters(String familyName) {
    List<String> splitName = familyName.split(' ');
    if (splitName.length > 1) {
      return '${splitName[0][0]}${splitName[1][0]}';
    }
    return '${splitName[0][0]}';
  }
}
