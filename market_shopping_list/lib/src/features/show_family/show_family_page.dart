import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/show_family/show_family_components.dart';
import 'package:market_shopping_list/src/features/show_family/show_family_contoller.dart';
import 'package:market_shopping_list/src/shared/components/family_card_component.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class ShowFamilyPage extends StatefulWidget {
  Family family;

  ShowFamilyPage({required this.family});

  @override
  _ShowFamilyPageState createState() => _ShowFamilyPageState();
}

class _ShowFamilyPageState extends State<ShowFamilyPage>
    with ShowFamilyCompoenents {
  late ShowFamilyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ShowFamilyController(family: widget.family);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.family.value.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              FamilyCardComponent(family: _controller.family.value),
              SizedBox(height: 16.0),
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 4.0),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _controller.isLoadingShopingList,
                        builder: (context, value, child) => searchInput(
                            onChange: _controller.searchShopingList,
                            isEnable: !_controller.isLoadingShopingList.value),
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        SizedBox(width: 10.0),
                        IconButton(
                          icon: Icon(Icons.add_shopping_cart_outlined),
                          onPressed: () {
                            _controller.goToCreatePurchaseItemPage(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: _controller.isLoadingShopingList,
                builder: (_, bool value, ___) {
                  if (value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (_controller.shoppingListItensToShow.value.length == 0) {
                      return Container(
                        child: Text('Nenhuma lista de compras cadastrada'),
                      );
                    } else {
                      return ValueListenableBuilder(
                        valueListenable: _controller.shoppingListItensToShow,
                        builder: (_, value, ___) {
                          return _controller
                              .shoppingListItensToShow.value.length > 0
                              ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _controller
                                    .shoppingListItensToShow.value.length,
                                itemBuilder: (context, index) {
                                  ShoppingList shoppingList = _controller
                                      .shoppingListItensToShow.value[index];
                                  return cardShoppingListItem(
                                    shoppingList: shoppingList,
                                    onTap: () {
                                      _controller.goToCreatePurchaseItemPage(
                                          context,
                                          shoppingList: shoppingList);
                                    },
                                    onDelete: (){
                                      _controller.deleteShoppingList(shoppingList);
                                    }
                                  );
                                },
                              ) : Container(child: Text('Nada para apresentar'),);
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
