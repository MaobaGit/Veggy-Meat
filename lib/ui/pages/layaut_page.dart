import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/ui/ShoppingCartCubit/shoppingcart_cubit.dart';
import 'package:veggy/ui/widgets/navbar.dart';

class LayautPage extends StatelessWidget {
  LayautPage(this.bodyWidget) : super();
  final Widget bodyWidget;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShoppingcartCubit>(context).loadShoppingCartList();
    return Scaffold(appBar: Navbar(), body: bodyWidget,);
  }
}
