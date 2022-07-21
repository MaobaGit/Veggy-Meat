import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/router/routes.dart';
import 'package:veggy/theme/theme.dart';
import 'package:veggy/ui/ShoppingCartCubit/shoppingcart_cubit.dart';
import 'package:veggy/ui/pages/layaut_page.dart';

void main() {
  Flurorouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShoppingcartCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Veggy',
          initialRoute: '/',
          theme: theme(),
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: Flurorouter.router.generator,
          builder: (_, child) {

            return LayautPage(child!);
          },
        ));
  }
}
