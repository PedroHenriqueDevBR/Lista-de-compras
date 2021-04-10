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
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.isDone,
        builder: (_, bool isDone, ___) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 750),
            curve: Curves.easeOutQuint,
            width: MediaQuery.of(context).size.width,
            height: isDone ? 0 : MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: _controller.colorUtil.primaryColor,
            ),
            child: isDone
                ? Container()
                : Center(
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(22.0),
                          width: 160,
                          child: Image.asset(_controller.imageReference.logo),
                        ),
                        CircularProgressIndicator.adaptive(),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
