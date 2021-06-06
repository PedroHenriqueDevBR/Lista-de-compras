import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/core/colors_util.dart';

class ListFamiliesHeader extends StatelessWidget {
  Size size;
  Widget? child;
  int pendingCount;

  ListFamiliesHeader({
    Key? key,
    required this.size,
    this.child,
    required this.pendingCount,
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
                Container(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.pendingCount == 0 ? 'Nenhuma lista de compras pendente ' : 'Voce possui ${this.pendingCount} lista(s) de compras pendentes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
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
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: child != null ? child : Container(),
          ),
        ],
      ),
    );
  }
}
