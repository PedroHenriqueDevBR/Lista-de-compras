import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/product.dart';

abstract class IProductStorage {
  Future<void> SelectAllProductsFromFamily({required Family family});

  Future<void> updateProduc({required Product product});

  Future<void> deleteProduct({required Product product});
}
