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
    _controller.isLoggedPerson();
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
                    valueListenable: _controller.logged,
                    builder: (_, __, ___) {
                      if (_controller.logged.value) {
                        return loginActionButton(
                          title: 'Encerrar sessão',
                          icon: Icons.close_outlined,
                          action: _controller.signOut,
                        );
                      } else {
                        return loginActionButton(
                          title: 'Gmail',
                          icon: Icons.mail_outline,
                          action: _controller.loginWithGoogle,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 16),
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
}
