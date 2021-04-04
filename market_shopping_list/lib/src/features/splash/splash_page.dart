import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/splash/splash_controller.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController(
      context: this.context,
      personStorage: PersonRepository(),
    );
    _controller.isLoggedPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _controller.colorUtil.bgColor,
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(22.0),
              width: 150,
              child: Image.asset(_controller.imageReference.logo),
            ),
            SizedBox(height: 8),
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text('Carregando...'),
          ],
        ),
      ),
    );
  }
}
