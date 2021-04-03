import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/login/components/login_component.dart';
import 'package:market_shopping_list/src/features/login/login_controller.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository,.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginConponent {
  late LoginController _controller;

  void updateState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = LoginController(
      personStorage: PersonRepository(),
      context: this.context,
    );
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
              child: headerLogin(),
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
                    valueListenable: _controller.loading,
                    builder: (_, __, ___) {
                      return loginActionButton(
                        title: 'Gmail',
                        icon: Icons.mail_outline,
                        action: _controller.loginWithGoogle,
                        disable: _controller.loading.value,
                      );
                    },
                  ),
                  SizedBox(height: 16),
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
