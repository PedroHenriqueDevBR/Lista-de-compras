import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/home_controller.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    this._controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Famílias'),
      ),
      body: ListView.builder(
        itemCount: _controller.families.length,
        padding: EdgeInsets.all(8),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _familyCardItem(_controller.families[index]);
        },
      ),
      drawer: Drawer(
        elevation: 8.0,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _drawerHead(),
              Divider(),
              _drawerItemConfigure(icon: Icons.home, text: 'Familias', action: () {}),
              _drawerItemConfigure(icon: Icons.calendar_today, text: 'Pendentes', action: () {}),
              _drawerItemConfigure(icon: Icons.settings, text: 'Configurações', action: () {}),
              _drawerItemConfigure(icon: Icons.exit_to_app_outlined, text: 'Encerrar sessão', action: () {}),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('Famílias'),
              ),
              ..._getFamilieListForDrawer(),
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

  Widget _familyCardItem(Family family) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            image: NetworkImage('https://images.pexels.com/photos/1724888/pexels-photo-1724888.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
          ),
        ),
        height: 130,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    family.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset.zero,
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Grupo pertencente a ${family.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerHead() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(
            _controller.imageReference.logo,
            width: 40,
          ),
          SizedBox(width: 16),
          Text('Lista de compras'),
        ],
      ),
    );
  }

  Widget _drawerItemConfigure({
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

  Widget _drawerFamilyItem({
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
        backgroundColor: _controller.colorUtil.secondaryColor,
      ),
      title: Text(family.name),
    );
  }

  List<Widget> _getFamilieListForDrawer() {
    List<Widget> familieList = [];
    for (Family family in _controller.families) {
      familieList.add(_drawerFamilyItem(family: family));
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
