import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/components/home_components.dart';
import 'package:market_shopping_list/src/features/home/home_controller.dart';
import 'package:market_shopping_list/src/features/home/pages/families/families_page.dart';
import 'package:market_shopping_list/src/features/home/pages/pendencies/pendencies_page.dart';
import 'package:market_shopping_list/src/features/home/pages/settings/settings_page.dart';

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
    this._controller = HomeController(context: this.context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Famílias'),
        foregroundColor: Colors.indigo,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuItem>[
              PopupMenuItem(
                child: Text('Compartilhar'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Referências'),
                value: 1,
              ),
            ],
          )
        ],
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
              ValueListenableBuilder(
                valueListenable: _controller.families,
                builder: (context, value, child) => Column(
                  children: [
                    ...getFamilieListForDrawer(families: _controller.families.value),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
