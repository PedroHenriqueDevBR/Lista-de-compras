import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/login/login_controller.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ImageReference imageReference = ImageReference();
  ColorUtil _colorUtil = ColorUtil();
  LoginController _controller = LoginController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: _colorUtil.bgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imageReference.logo,
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'Lista de compras da familia',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Acompanhe as compras da familia de forma colaborativa.',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.all(16),
                    color: _colorUtil.gmailColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        Text(
                          'Gmail',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _controller.goToHomePage(context);
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Utilize a sua conta do Google para acessar a aplicação.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
