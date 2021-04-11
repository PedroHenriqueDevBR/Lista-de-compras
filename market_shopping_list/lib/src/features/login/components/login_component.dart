import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/login/login_controller.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class LoginConponent {
  ColorUtil _colorUtil = ColorUtil();
  ImageReference _imageReference = ImageReference();

  Widget headerLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          _imageReference.logo,
          height: 100,
          width: 100,
        ),
        Text(
          'Lista de compras',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8),
        Text(
          'Gerenciamento de listas de compras de forma colaborativa.',
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget loginActionButton({
    required String title,
    required IconData icon,
    required Function action,
    bool disable = null ?? false,
  }) {
    return MaterialButton(
      padding: EdgeInsets.all(16),
      color: disable ? Colors.transparent : _colorUtil.gmailColor,
      elevation: disable ? 0 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      height: 50,
      child: disable
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
      onPressed: () {
        action();
      },
    );
  }
}