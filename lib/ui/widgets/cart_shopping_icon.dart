import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/router/routes.dart';

import 'package:veggy/ui/ShoppingCartCubit/shoppingcart_cubit.dart';

class IconCartShoppingIndicator extends StatelessWidget {
  const IconCartShoppingIndicator() : super();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        NavigationService.navigateTo(Flurorouter.shoppingCartRoute);
      },
      icon: Badge(
        position: BadgePosition.topEnd(top: -6, end: -3),
        animationDuration: Duration(milliseconds: 300),
        animationType: BadgeAnimationType.scale,
        badgeContent: BlocBuilder<ShoppingcartCubit, ShoppingcartState>(
          buildWhen: (previous, current) =>
              previous.listProducts != current.listProducts,
          builder: (context, state) {
            return Text(
              state.listProducts.length.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            );
          },
        ),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.green,
        ),
      ),
    );
  }
}
