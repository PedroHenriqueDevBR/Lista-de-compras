import 'package:market_shopping_list/src/shared/dal/interfaces/family_sql_interface.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/database_sql.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';

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
    insert into ${DatabaseSQL.SHOPPING_LIST}(title, description, create_at, family)
    values ('${shoppingList.title}', '${shoppingList.description}', '${shoppingList.createdAt.millisecondsSinceEpoch}', ${family.id});
    ''';
  }

  @override
  String deleteFamily(Family family) {
    return '''
    delete from ${DatabaseSQL.FAMILY} where id = ${family.id};
    ''';
  }
}
