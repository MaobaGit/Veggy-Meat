part of 'llistproducts_cubit.dart';

abstract class LlistproductsState extends Equatable {
  const LlistproductsState({this.listProdusctsLoaded = const []});
  final List<ProductApi> listProdusctsLoaded;
  @override
  List<Object> get props => [];
}

class LlistproductsInitial extends LlistproductsState {}
