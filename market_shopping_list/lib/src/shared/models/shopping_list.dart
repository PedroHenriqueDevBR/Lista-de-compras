import 'dart:convert';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';

class ShoppingList {
  dynamic? id;
  late String created_by;
  late String title;
  late String description;
  late bool is_done; // TODO: Change variable name to isDone
  late DateTime created_at;
  late String familyID;
  List<PurchaseItem> productItens = [];

  ShoppingList({
    this.id,
    required this.familyID,
    required this.created_by,
    required this.title,
    required this.description,
    required this.created_at,
    this.is_done = null ?? false,
  });

  ShoppingList.createWithNowDate({
    this.id,
    required this.familyID,
    required this.created_by,
    required this.title,
    required this.description,
    this.is_done = null ?? false,
  }) {
    this.created_at = DateTime.now();
  }

  ShoppingList.cleanData() {
    this.familyID = '';
    this.created_by = '';
    this.title = '';
    this.description = '';
    this.is_done = false;
    this.created_at = DateTime.now();
  }

  void addProductItem(PurchaseItem item) {
    this.productItens.add(item);
  }

  String get createdAtFormatedToLocalDate {
    DateTime date = this.created_at;
    return '${date.day}/' + '${date.month}/' + '${date.year}';
  }

  String get productsToString {
    StringBuffer out = StringBuffer();
    for (PurchaseItem product in this.productItens) {
      out.writeln(product.toString());
    }
    return out.toString();
  }

  String formatDateToSave() {
    return this.created_at.toUtc().toString();
  }

  static DateTime formatDateToInstance(String formattedDate) {
    return DateTime.parse(formattedDate);
  }

  List<Map<String, dynamic>> getProductItensToMap() {
    List<Map<String, dynamic>> out = [];
    for (PurchaseItem item in productItens) {
      out.add(item.toMap());
    }
    return out;
  }

  static List<PurchaseItem> getPurchaseItemListFromMap(List<dynamic> productItens) {
    List<PurchaseItem> out = [];
    if (productItens.length > 0) {
      for (Map<String, dynamic> itemMap in productItens) {
        out.add(PurchaseItem.fromMap(itemMap));
      }
    }
    return out;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'familyID': familyID,
      'created_by': created_by,
      'title': title,
      'description': description,
      'is_done': is_done,
      'created_at': formatDateToSave(),
      'productItens': getProductItensToMap(),
    };
  }

  factory ShoppingList.fromMap(Map<String, dynamic> map) {
    ShoppingList shoppingList = ShoppingList(
      id: map['id'],
      familyID: map['familyID'],
      created_by: map['created_by'],
      title: map['title'],
      description: map['description'],
      is_done: map['is_done'],
      created_at: formatDateToInstance(map['created_at']),
    );
    shoppingList.productItens = getPurchaseItemListFromMap(map['productItens']);
    return shoppingList;
  }

  @override
  String toString() {
    return '''ShoppingList(
                id: ${id ?? "Empty"}, 
                familyID: ${familyID},
                created_by: ${created_by},
                title: $title, 
                description: $description, 
                is_done: $is_done,
                created_at: $createdAtFormatedToLocalDate, 
                productsItens: $productsToString)
              ${"-" * 30}''';
  }

  String toJson() => json.encode(toMap());

  factory ShoppingList.fromJson(String source) => ShoppingList.fromMap(json.decode(source));
}
