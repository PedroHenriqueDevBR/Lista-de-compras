import '../../models/family.dart';
import '../../models/shopping_list.dart';
import '../interfaces/family_sql_interface.dart';
import 'database_sql.dart';

class FamilySQLite implements IFamilySQL {
  @override
  String createFamily(Family family) {
    return '''
    insert into ${DatabaseSQL.FAMILY}(name)
    values ('${family.name}');
    ''';
  }

  @override
  String getAllFamilies() {
    return '''
    select * from ${DatabaseSQL.FAMILY} order by name;
    ''';
  }

  @override
  String updateFamily(Family family) {
    return '''
    update ${DatabaseSQL.FAMILY}
    set name = '${family.name}'
    where id = ${family.id};
    ''';
  }

  @override
  String addShoppingList(Family family, ShoppingList shoppingList) {
    return '''
    insert into ${DatabaseSQL.SHOPPING_LIST}(title, description, create_at, family, is_done)
    values ('${shoppingList.title}', '${shoppingList.description}', '${shoppingList.createdAt.millisecondsSinceEpoch}', ${family.id}, ${shoppingList.isDone ? 1 : 0});
    ''';
  }

  @override
  String deleteFamily(Family family) {
    return '''
    delete from ${DatabaseSQL.FAMILY} where id = ${family.id};
    ''';
  }

  @override
  String getFamilyByShoppingList(ShoppingList shoppingList) {
    return '''
    select f.* from ${DatabaseSQL.FAMILY} as f inner join ${DatabaseSQL.SHOPPING_LIST} as sl
    on f.id = sl.family
    where sl.id = ${shoppingList.id};
    ''';
  }
}
