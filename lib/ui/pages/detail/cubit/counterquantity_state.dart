part of 'counterquantity_cubit.dart';

class DetailState extends Equatable {
  final double quantityUnits;
  final NumberNoEmpty quantityGranel;
  final ProductApi productApi;
  final List<ProductApi> listSameProduct;
  DetailState(
      {this.quantityUnits = 1,
      this.quantityGranel = const NumberNoEmpty.dirty('100'),
      this.listSameProduct = const [],
      required this.productApi});

  DetailState copyWith(
      {double? quantityUnits,
      NumberNoEmpty? quantityGranel,
      List<ProductApi>? listSameProduct,
      ProductApi? productApi}) {
    return DetailState(
        quantityUnits: quantityUnits ?? this.quantityUnits,
        quantityGranel: quantityGranel ?? this.quantityGranel,
        listSameProduct: listSameProduct ?? this.listSameProduct,
        productApi: productApi ?? this.productApi);
  }

  @override
  List<Object> get props =>
      [quantityGranel, quantityUnits, productApi, listSameProduct];
}
