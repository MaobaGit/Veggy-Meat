import 'package:veggy/data/local/local_db.dart';
import 'package:veggy/domain/models/cart_product.dart';

class ShoppingCartLocalDBUsecase {
  final _localDB = new LocalBD();

  void saveShoppingCart(List<CartProduct> list) {
    _localDB.saveShoppingCart(list);
  }

  Future<List<CartProduct>?> getShoppingCart() async {
    return _localDB.getShoppingCart();
  }
}
