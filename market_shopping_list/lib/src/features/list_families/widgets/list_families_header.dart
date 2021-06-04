import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/core/colors_util.dart';

class ListFamiliesHeader extends StatelessWidget {
  Size size;
  Widget? child;

  ListFamiliesHeader({
    Key? key,
    required this.size,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
      color: AppColors.primaryColor,
      width: size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 40.0,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Voce possui 2 listas de compras pendentes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        onPressed: () {
                          print('Deve ser implementado'); // Implementar
                        },
                        child: Text(
                          'Clique aqui e saiba mais',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            child: child != null ? child : Container(),
          ),
        ],
      ),
    );
  }
}
