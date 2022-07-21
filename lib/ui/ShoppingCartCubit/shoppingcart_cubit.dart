import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:veggy/domain/models/cart_product.dart';
import 'package:veggy/domain/usecases/shopping_cart_localdb_usecase.dart';

part 'shoppingcart_state.dart';

class ShoppingcartCubit extends Cubit<ShoppingcartState> {
  final _cartLocalDBUsecase = new ShoppingCartLocalDBUsecase();
  ShoppingcartCubit() : super(ShoppingcartState());

  void loadShoppingCartList() async {
    if (state.listProducts.isEmpty) {
      final _listFromLocalDB = await _cartLocalDBUsecase.getShoppingCart();
      emit(state.copyWith(listProducts: _listFromLocalDB ?? []));
    }
  }

  void addProduct(CartProduct cartProduct) {
    final List<CartProduct> auxList = List.from(state.listProducts);
    final productExistedIndex = auxList.indexWhere((element) =>
        element.product.codigoArticulo == cartProduct.product.codigoArticulo);
    if (productExistedIndex >= 0) {
      auxList[productExistedIndex]
          .product
          .addQuantity(cartProduct.product.cantidad);
    } else {
      auxList.add(cartProduct);
    }

    _cartLocalDBUsecase.saveShoppingCart(auxList);
    emit(state.copyWith(listProducts: auxList));
  }

  void cleanShoppingCart() {
    emit(state.copyWith(listProducts: []));
  }

  void deleteProduct(CartProduct cartProduct) {
    final List<CartProduct> auxList = List.from(state.listProducts)
      ..removeWhere((element) =>
          element.product.codigoArticulo == cartProduct.product.codigoArticulo);
    _cartLocalDBUsecase.saveShoppingCart(auxList);
    emit(state.copyWith(listProducts: auxList));
  }
}
