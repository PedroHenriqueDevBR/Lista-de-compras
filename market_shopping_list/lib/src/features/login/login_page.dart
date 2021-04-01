import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/login/login_controller.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository,.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _controller;

  void updateState() {
    setState(() {});
  }

  @override
  void initState() {
    _controller = LoginController(
      personStorage: PersonRepository(),
    );
    _controller.isLoggedPerson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(0),
              color: _controller.colorUtil.bgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _controller.imageReference.logo,
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
          Divider(
            height: 2,
            color: _controller.colorUtil.primaryColor,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _controller.logged,
                    builder: (_, __, ___) {
                      if (_controller.logged.value) {
                        return endSessionButton();
                      } else {
                        return loginWithGoogleButton();
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  ValueListenableBuilder(
                    valueListenable: _controller.errorMessage,
                    builder: (_, __, ___) => Text(
                      _controller.errorMessage.value.isNotEmpty ? _controller.errorMessage.value : 'Utilize a sua conta do Google para acessar a aplicação.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginWithGoogleButton() {
    return MaterialButton(
      padding: EdgeInsets.all(16),
      color: _controller.colorUtil.gmailColor,
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
        _controller.loginWithGoogle();
      },
    );
  }

  Widget endSessionButton() {
    return MaterialButton(
      padding: EdgeInsets.all(16),
      color: _controller.colorUtil.gmailColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.exit_to_app_outlined,
            color: Colors.white,
          ),
          Text(
            'Encerrar sessão',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      onPressed: () {
        _controller.signOut();
      },
    );
  }
}
