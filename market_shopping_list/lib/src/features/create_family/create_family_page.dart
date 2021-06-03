import 'package:flutter/material.dart';

class CreateFamilyPage extends StatefulWidget {
  @override
  _CreateFamilyPageState createState() => _CreateFamilyPageState();
}

class _CreateFamilyPageState extends State<CreateFamilyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fámilia'),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Column(
          children: [
            TextFormField(),
          ],
        )),
      ),
    );
  }
}
