import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/router/routes.dart';
import 'package:veggy/theme/colors.dart';
import 'package:veggy/ui/ShoppingCartCubit/shoppingcart_cubit.dart';
import 'package:veggy/util/sizingInfo.dart';
import 'package:veggy/values/responsiveApp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';

//Error de borde en tablet

class ShoppingCart extends StatelessWidget {
  ShoppingCart() : super();
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  final _scrollController3 = ScrollController();
  late MoneyFormatter fmf;

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    final responsiveApp = ResponsiveApp(context);
    return Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController3,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              controller: _scrollController3,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Material(
                          color: Colors.white,
                          child: Text(
                            'Carrito de compras',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: Scrollbar(
                              isAlwaysShown: true,
                              controller: _scrollController2,
                              child: SingleChildScrollView(
                                controller: _scrollController2,
                                scrollDirection: Axis.vertical,
                                child: isMobileAndTablet(context)
                                    ? listProductMovil(
                                        themeText,
                                        responsiveApp,
                                        context,
                                      )
                                    : listProduct(
                                        themeText,
                                        responsiveApp,
                                        context,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: resume(themeText, responsiveApp, context),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

/*Este método crea el bloque donde se mostraran los productos del carrito de compras, por medio de
columnas y filas, obteniendo del state los datos necesarios como: nombre, precio unitario, iva,
imagen y cantidad seleccionada, ademas contiene los ajuste para pantalles de escritorio.
   @Params :  TextTheme themeText, ResponsiveApp responsiveApp, BuildContext context
   @Return : Column*/
  Widget listProduct(
      TextTheme themeText, ResponsiveApp responsiveApp, BuildContext context) {
    return Material(
      child: BlocBuilder<ShoppingcartCubit, ShoppingcartState>(
        builder: (context, state) {
          var sizeHeight = (150 * state.listProducts.length).toDouble();
          if (sizeHeight >= 700) {
            sizeHeight = 700;
          }
          return Column(
            children: [
              Container(
                height: 40,
                width: 1000,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Container(
                        color: Colors.white,
                        height: 60,
                        width: 250,
                        child: Text(
                          'Nombre',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Container(
                        color: Colors.white,
                        height: 50,
                        width: 150,
                        child: Text(
                          'Precio Unitario',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        color: Colors.white,
                        height: 50,
                        width: 100,
                        child: Text(
                          'Cantidad',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        color: Colors.white,
                        height: 50,
                        width: 200,
                        child: Text(
                          'Precio X cantidad',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: sizeHeight,
                width: 1000,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: state.listProducts.length,
                  itemBuilder: (context, index) {
                    final cantidad = state.listProducts[index].isGranel
                        ? state.listProducts[index].product.cantidad * 1000
                        : state.listProducts[index].product.cantidad;
                    final price = state.listProducts[index].isGranel
                        ? state.listProducts[index].product.precioSinIva / 1000
                        : state.listProducts[index].product.precioSinIva;
                    var precioxUnidad = price * cantidad;
                    return Container(
                      height: 150,
                      width: 800,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Colors.grey.shade400, width: 0.5))),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: state
                                      .listProducts[index].imageUrl.isNotEmpty
                                  ? FadeInImage(
                                      placeholder: AssetImage(
                                          'assets/icons/Pulse-1s-200px.gif'),
                                      image: NetworkImage(
                                          state.listProducts[index].imageUrl))
                                  : Image.asset(
                                      'assets/images/imagen_no_disponible.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              color: Colors.white,
                              height: 60,
                              width: 250,
                              child: Text(
                                state.listProducts[index].name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              width: 150,
                              child: Text(
                                '₡ ' + price.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              width: 50,
                              child: Text(
                                'X ' +
                                    cantidad.toString() +
                                    (state.listProducts[index].isGranel
                                        ? 'g'
                                        : 'u'),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              width: 150,
                              child: Text(
                                '₡ ' + precioxUnidad.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: IconButton(
                                icon: Icon(Icons.delete, size: 40),
                                color: Colors.red,
                                onPressed: () {
                                  context
                                      .read<ShoppingcartCubit>()
                                      .deleteProduct(state.listProducts[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

/*Este método crea el bloque donde se mostraran los productos del carrito de compras, por medio de
columnas y filas, obteniendo del state los datos necesarios como: nombre, precio unitario, iva,
imagen y cantidad seleccionada, ademas contiene los ajuste para pantalles de dispositivos moviles.
   @Params :  TextTheme themeText, ResponsiveApp responsiveApp, BuildContext context
   @Return : Column*/
  Widget listProductMovil(
      TextTheme themeText, ResponsiveApp responsiveApp, BuildContext context) {
    return BlocBuilder<ShoppingcartCubit, ShoppingcartState>(
      builder: (context, state) {
        var sizeHeight = (150 * state.listProducts.length).toDouble();
        if (sizeHeight >= 650) {
          sizeHeight = 650;
        }
        return Column(
          children: [
            Container(
              height: 40,
              width: 500,
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Container(
                      color: Colors.white,
                      height: 50,
                      width: 130,
                      child: Text(
                        'Nombre',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      color: Colors.white,
                      height: 50,
                      width: 100,
                      child: Text(
                        'Precio Unitario',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      color: Colors.white,
                      height: 50,
                      width: 70,
                      child: Text(
                        'Cantidad',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      color: Colors.white,
                      height: 50,
                      width: 100,
                      child: Text(
                        'Precio X cantidad',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              child: Container(
                height: sizeHeight,
                width: 500,
                child: ListView.builder(
                  itemCount: state.listProducts.length,
                  itemBuilder: (context, index) {
                    final cantidad = state.listProducts[index].isGranel
                        ? state.listProducts[index].product.cantidad * 1000
                        : state.listProducts[index].product.cantidad;
                    final price = state.listProducts[index].isGranel
                        ? state.listProducts[index].product.precioSinIva / 1000
                        : state.listProducts[index].product.precioSinIva;
                    var precioxUnidad = price * cantidad;
                    return Container(
                      height: 150,
                      width: 450,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Colors.grey.shade400, width: 0.5))),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                                height: 50,
                                width: 50,
                                child: state
                                        .listProducts[index].imageUrl.isNotEmpty
                                    ? FadeInImage(
                                        placeholder: AssetImage(
                                            'assets/icons/Pulse-1s-200px.gif'),
                                        image: NetworkImage(
                                            state.listProducts[index].imageUrl))
                                    : Image.asset(
                                        'assets/images/imagen_no_disponible.png')),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              width: 130,
                              child: Text(
                                state.listProducts[index].name,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 100,
                              child: Text(
                                '₡ ' + price.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Text(
                                'X ' +
                                    cantidad.toString() +
                                    (state.listProducts[index].isGranel
                                            ? 'g'
                                            : 'u')
                                        .toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 100,
                              child: Text(
                                '₡ ' + precioxUnidad.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  context
                                      .read<ShoppingcartCubit>()
                                      .deleteProduct(state.listProducts[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

/*Este método crea la tabla detalle de compra, mostrando los impuestos, subtotal y total de la compra,
todo obtenido del state, ademas formateando las cantidades con la libreria MoneyFormatter.
   @Params :  TextTheme themeText, ResponsiveApp responsiveApp, BuildContext context
   @Return : container*/
  Widget resume(
      TextTheme themeText, ResponsiveApp responsiveApp, BuildContext context) {
    return BlocBuilder<ShoppingcartCubit, ShoppingcartState>(
      builder: (context, state) {
        fmf = MoneyFormatter(amount: state.subtotalShoppingCart());
        MoneyFormatterOutput subFO = fmf.output;
        fmf = MoneyFormatter(amount: state.impuestoShoppingCart());
        MoneyFormatterOutput impuestoFO = fmf.output;
        fmf = MoneyFormatter(amount: state.totalShoppingCart());
        MoneyFormatterOutput totalFO = fmf.output;
        return Container(
            height: 300,
            width: 300,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ColorsApp.colorPaletteorange),
            child: ListView(children: [
              Card(
                color: ColorsApp.colorPaletteorange,
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'Detalle de compra',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Card(
                color: ColorsApp.colorPaletteorange,
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'SubTotal',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text(
                    '₡ ' + subFO.nonSymbol,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Card(
                color: ColorsApp.colorPaletteorange,
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'Impuestos',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text(
                    '₡ ' + impuestoFO.nonSymbol,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Card(
                color: ColorsApp.colorPaletteorange,
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'Total',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text(
                    '₡ ' + totalFO.nonSymbol,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                    onPressed: state.listProducts.isNotEmpty
                        ? () {
                            NavigationService.navigateTo(
                                Flurorouter.formPreOrderRoute);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        primary: ColorsApp.colorPaletteGreen,
                        padding: EdgeInsets.all(20)),
                    child: Text(
                      'Finalizar compra',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.25),
                    )),
              )
            ]));
      },
    );
  }
}
