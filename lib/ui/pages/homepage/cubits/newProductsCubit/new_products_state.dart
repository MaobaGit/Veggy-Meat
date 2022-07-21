part of 'new_products_cubit.dart';

class NewProductState extends Equatable {
  final List<ProductApi> listNewProducts;
  NewProductState({this.listNewProducts = const []});

  NewProductState copyWith({
    List<ProductApi>? listNewProducts,
  }) {
    return NewProductState(
      listNewProducts: listNewProducts ?? this.listNewProducts,
    );
  }

  @override
  List<Object> get props => [listNewProducts];
}
