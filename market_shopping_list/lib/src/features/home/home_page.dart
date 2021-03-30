import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/home_controller.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _controller = HomeController();
  ImageReference _imageReference = ImageReference();

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
          Family family = _controller.families[index];
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
        },
      ),
      drawer: Drawer(
        elevation: 8.0,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      _imageReference.logo,
                      width: 40,
                    ),
                    SizedBox(width: 16),
                    Text('Lista de compras'),
                  ],
                ),
              ),
              Divider(),
              TextButton.icon(
                icon: Icon(Icons.home),
                label: Text('Familias'),
                onPressed: () {},
              ),
              TextButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text('Compras pendentes'),
                onPressed: () {},
              ),
              TextButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Configurações'),
                onPressed: () {},
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
