import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/router/routes.dart';
import 'package:veggy/theme/colors.dart';
import 'package:veggy/ui/ShoppingCartCubit/shoppingcart_cubit.dart';
import 'package:veggy/ui/pages/formpage/formCubit/form_cubit.dart';
import 'package:veggy/ui/pages/formpage/widgets/background_veggy.dart';
import 'package:veggy/ui/pages/formpage/widgets/custom_title.dart';
import 'package:veggy/ui/pages/formpage/widgets/form_preorder.dart';

class FormPreorderPage extends StatelessWidget {
  const FormPreorderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final preorderForm = FormPreOrder();
    return BlocProvider(
      create: (context) => FormCubit(),
      child: Scaffold(
          body: Scrollbar(
        // isAlwaysShown: true,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            (size.width > 1000)
                ? _DesktopBody(child: preorderForm)
                : _MobileBody(child: preorderForm),

            // LinksBar
          ],
        ),
      )),
    );
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24, left: 24, top: 24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Column(
              children: [
                CustomTitle(),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 550,
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<FormCubit, FormCubitState>(
      listenWhen: (previous, current) =>
          previous.statusSummit != current.statusSummit,
      listener: (context, state) {
        if (state.statusSummit == StatudSummit.summited) {
          context.read<ShoppingcartCubit>().cleanShoppingCart();
          _showDialog(context, '¡Orden enviada exitosamente!', false);
        } else {
          _showDialog(
              context,
              '¡No se puedo enviar la orden!\nError:${state.errormessage}',
              true);
        }
      },
      child: Container(
        width: size.width,
        height: size.height * 0.97,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Twitter Background
            Expanded(child: Background()),

            // View Container

            Container(
              width: 600,
              alignment: Alignment.center,
              height: double.infinity,
              child: Container(
                width: 500,
                height: 670,
                child: Card(
                  child: Column(
                    children: [
                      CustomTitle(),
                      SizedBox(height: 24),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var _txtCustomHead = TextStyle(
  color: ColorsApp.colorPaletteGreen,
  fontSize: 23.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Card Popup if success payment
_showDialog(BuildContext ctx, String message, bool error) {
  showDialog(
    barrierDismissible: false,
    context: ctx,
    builder: (context) => SimpleDialog(
      backgroundColor: ColorsApp.cardColor,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: ColorsApp.cardColor,
          child: error
              ? Image.asset(
                 "assets/images/error.png",
                  height: 110.0,
                  // color: Colors.transparent,
                )
              : Image.asset(
                  "assets/images/checklist.png",
                  height: 110.0,
                  color: Colors.lightGreen,
                ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            message,
            style: _txtCustomHead,
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 8.0, top: 10),
          child: Container(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
                color: ColorsApp.colorPaletteGreen,
                textColor: Colors.white,
                onPressed: () => error
                    ? Navigator.of(context).pop()
                    : NavigationService.replaceTo(Flurorouter.rootRoute),
                child: Text('Listo')),
          ),
        )
      ],
    ),
  );
}
