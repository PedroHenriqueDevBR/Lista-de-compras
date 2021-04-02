import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/components/home_components.dart';
import 'package:market_shopping_list/src/features/home/home_controller.dart';
import 'package:market_shopping_list/src/features/home/pages/families/families_page.dart';
import 'package:market_shopping_list/src/features/home/pages/pendencies/pendencies_page.dart';
import 'package:market_shopping_list/src/features/home/pages/settings/settings_page.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository,.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeComponents {
  late HomeController _controller;
  late List<Widget> _pages;
  int _currentIndex = 0;

  void _changePage({required int pageIndex}) {
    setState(() {
      _currentIndex = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    this._pages = [
      FamiliesPage(),
      PendenciesPage(),
      SettingsPage(),
    ];
    this._controller = HomeController(
      context: this.context,
      personStorage: PersonRepository(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Famílias'),
      ),
      body: _pages[_currentIndex],
      drawer: Drawer(
        elevation: 8.0,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerHead(),
              Divider(),
              drawerItemConfigure(
                icon: Icons.home,
                text: 'Familias',
                action: () {
                  _changePage(pageIndex: 0);
                },
              ),
              drawerItemConfigure(
                icon: Icons.calendar_today,
                text: 'Pendentes',
                action: () {
                  _changePage(pageIndex: 1);
                },
              ),
              drawerItemConfigure(
                icon: Icons.settings,
                text: 'Configurações',
                action: () {
                  _changePage(pageIndex: 2);
                },
              ),
              drawerItemConfigure(
                icon: Icons.exit_to_app_outlined,
                text: 'Encerrar sessão',
                action: _controller.endSession,
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('Famílias'),
              ),
              ...getFamilieListForDrawer(families: _controller.families),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: _controller.colorUtil.secondaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            builder: (context) => Wrap(
              children: [
                Column(
                  children: [
                    ListTile(
                      title: Text('Criar família'),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('Entrar em uma família'),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
