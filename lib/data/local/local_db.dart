import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:veggy/domain/models/cart_product.dart';
import 'package:veggy/domain/models/product_detail.dart';

class LocalBD {
  void saveProductDetailState(ProductDetail product) async {
    final prefs = await SharedPreferences.getInstance();
    final encodeMap = jsonEncode(product.toJson());
    prefs.setString(
      'stateProductDetail',
      encodeMap,
    );
  }

  Future<ProductDetail?> getProductDetailState() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('stateProductDetail');

    if (data != null) {
      return ProductDetail.fromJson(jsonDecode(data));
    }
    return null;
  }

  void saveShoppingCart(List<CartProduct> list) async {
    final prefs = await SharedPreferences.getInstance();
    final listJson = list.map((e) => e.toJson()).toList();
    final encodeMap = jsonEncode(listJson);
    prefs.setString(
      'shoppingCart',
      encodeMap,
    );
  }

  Future<List<CartProduct>?> getShoppingCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('shoppingCart');

    if (data != null) {
      final List decodeData = jsonDecode(data);
      return decodeData
          .map<CartProduct>((e) => CartProduct.fromJson(e))
          .toList();
    }
    return null;
  }
}
