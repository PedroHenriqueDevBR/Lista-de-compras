import 'package:flutter/material.dart';

class ListFamiliesHeader extends StatelessWidget {
  Size size;

  ListFamiliesHeader({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: size.width,
        child: Text(
          'Voce possui 2 listas de compras pendentes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
