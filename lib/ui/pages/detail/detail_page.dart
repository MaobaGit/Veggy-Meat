import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggy/domain/models/cart_product.dart';
import 'package:veggy/domain/models/product.dart';
import 'package:veggy/domain/models/product_api.dart';
import 'package:veggy/domain/models/product_detail.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/ui/ShoppingCartCubit/shoppingcart_cubit.dart';
import 'package:veggy/ui/pages/detail/cubit/counterquantity_cubit.dart';
import 'package:veggy/ui/widgets/bottomBar.dart';
import 'package:veggy/ui/widgets/counter_buttons.dart';
import 'package:veggy/ui/widgets/custom_inputs.dart';
import 'package:veggy/ui/widgets/product_card.dart';
import 'package:veggy/util/sizingInfo.dart';
import 'package:veggy/values/responsiveApp.dart';

class DetailPage extends StatelessWidget {
  DetailPage(
      {Key? key, this.product, required this.productId, required this.category})
      : super(key: key);
  final ProductDetail? product;
  final String productId;
  final String category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DeatailCubit(),
        child: Body(
          productDetail: product,
          category: category,
          productId: productId,
        ));
  }
}

class Body extends StatelessWidget {
  Body({this.productDetail, required this.category, required this.productId})
      : super();
  final ProductDetail? productDetail;
  final String category;
  final String productId;
  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    if (productDetail == null) {
      context.read<DeatailCubit>().productChanged(category, productId);
    } else {
      context.read<DeatailCubit>().productLoad(productDetail!);
    }
    final responsiveApp = ResponsiveApp(context);
    return Scrollbar(
      showTrackOnHover: true,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isMobileAndTablet(context))
              SizedBox(
                height: 50,
              ),
            Center(
              child: BlocBuilder<DeatailCubit, DetailState>(
                builder: (context, state) {
                  return Card(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                            height: responsiveApp.width <= 1197 &&
                                    responsiveApp.width >= 900
                                ? 450
                                : isMobileAndTablet(context)
                                    ? 350
                                    : 470,
                            width: responsiveApp.width <= 1007 &&
                                    responsiveApp.width >= 900
                                ? 450
                                : isMobileAndTablet(context)
                                    ? 350
                                    : 470,
                            child: state.productApi.imageUrl.isNotEmpty
                                ? FadeInImage(
                                    placeholder: AssetImage(
                                        'assets/icons/Pulse-1s-200px.gif'),
                                    image:
                                        NetworkImage(state.productApi.imageUrl),
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    'assets/images/imagen_no_disponible.png',
                                    fit: BoxFit.fill,
                                  )),
                        buildInfoProduct(
                            themeText, responsiveApp, context, state.productApi)
                      ],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 24, bottom: 14, left: isMobile(context) ? 20 : 0),
                    child: Text(
                      'Productos relacionados',
                      style: themeText.headline6,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        right: isMobile(context) ? 20 : 0,
                        left: isMobile(context) ? 20 : 0),
                    width: isMobile(context)
                        ? double.infinity
                        : isTablet(context)
                            ? 600
                            : 1000,
                    height: 350,
                    child: BlocBuilder<DeatailCubit, DetailState>(
                      buildWhen: (previous, current) =>
                          previous.listSameProduct != current.listSameProduct,
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: state.listSameProduct.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final price = state.listSameProduct[index].itemGroup == 'GRANEL'
                                ? (state.listSameProduct[index].listPrice / 1000)
                                : state.listSameProduct[index].listPrice;
                            return ProductCard(
                                title: state.listSameProduct[index].name,
                                price: (price+(price*(state.listSameProduct[index].misc1/100))).toStringAsFixed(2),
                                code: state.listSameProduct[index].code,
                                category: state.listSameProduct[index].itemGroup,
                                imageUrl: state.listSameProduct[index].imageUrl,
                                unidad: state.listSameProduct[index].unidad,
                                onPressCard: () {
                                  NavigationService.navigateToWithArguments(
                                      'detail/${state.listSameProduct[index].itemGroup}/${state.listSameProduct[index].code}',
                                      ProductDetail(
                                          product: state.listSameProduct[index],
                                          sameListProduct:
                                              state.listSameProduct));
                                },
                                onPressButton: () {
                                  final double quatity =
                                      state.productApi.itemGroup == 'GRANEL'
                                          ? 1 / 1000
                                          : 1.0;
                                  final double montoIva =
                                      state.listSameProduct[index].listPrice
                                          * (state.listSameProduct[index].misc1/100);
                                  final _product = Product(
                                      codigoArticulo:
                                          state.listSameProduct[index].code,
                                      cantidad: quatity,
                                      notas: '',
                                      envioParcial: '',
                                      precioSinIva: state.listSameProduct[index].listPrice,
                                      montoIva: montoIva,
                                      porcentajeIva: state
                                          .listSameProduct[index].misc1
                                          .toDouble(),
                                      codigoTarifa: '',
                                      precioIva: state.listSameProduct[index].listPrice + montoIva,
                                      porcentajeDescuento: 0,
                                      montoDescuento: 0,
                                      bonificacion: '',
                                      codImpuesto:
                                          state.listSameProduct[index].misc3);
                                  context.read<ShoppingcartCubit>().addProduct(
                                      CartProduct(
                                          product: _product,
                                          imageUrl: state
                                              .listSameProduct[index].imageUrl,
                                          isGranel:
                                              state.productApi.itemGroup ==
                                                  'GRANEL',
                                          name: state.listSameProduct[index].name));
                                });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            isDesktop(context) ? BottomBar() : Container(),
          ],
        ),
      ),
    );
  }

  Container buildInfoProduct(TextTheme themeText, ResponsiveApp responsiveApp,
      BuildContext context, ProductApi product) {
    final price = product.itemGroup == 'GRANEL'
        ? (product.listPrice / 1000) + ((product.listPrice / 1000) * (product.misc1/100))
        : product.listPrice + (product.listPrice * (product.misc1/100));
    return Container(
      height:
          responsiveApp.width <= 1197 && responsiveApp.width >= 900 ? 600 : 500,
      width: responsiveApp.width <= 1197 && responsiveApp.width >= 900
          ? 400
          : isMobileAndTablet(context)
              ? 600
              : 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 24,
              top: 24,
            ),
            child: Text(
              product.name,
              style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.25),
              textScaleFactor: isDesktop(context)
                  ? 1
                  : isMobileAndTablet(context)
                      ? 0.7
                      : 0.9,
              textAlign: TextAlign.justify,
            ),
          ),
          isMobile(context)
              ? SizedBox(
                  height: 24,
                )
              : Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
            child: Container(
              child: Text(
                  'Codigo de producto: ${product.code}\nCategoria : ${product.itemGroup}\nUnidad de medida: ${product.unidad}',
                  style: themeText.bodyText1,
                  textAlign: TextAlign.justify,
                  textScaleFactor: isDesktop(context)
                      ? 1
                      : isMobileAndTablet(context)
                          ? 0.9
                          : 1),
            ),
          ),
          isMobile(context)
              ? SizedBox(
                  height: 24,
                )
              : Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  size: 24,
                  color: Colors.green[200],
                ),
                SizedBox(
                  width: 5.0,
                ),
                product.itemGroup == 'GRANEL'
                    ? Text('₡ ${price.toStringAsFixed(2)} x gramo',
                        style: themeText.headline6)
                    : Text('₡ ${price.toStringAsFixed(2)}',
                        style: themeText.headline6),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          BlocBuilder<DeatailCubit, DetailState>(
            builder: (context, state) {
              return product.itemGroup == 'GRANEL'
                  ? Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Container(
                        width: 300,
                        child: TextFormField(
                          initialValue: state.quantityGranel.value,
                          onChanged: (value) => context
                              .read<DeatailCubit>()
                              .productQuatityGranelChanged(value),
                          style: TextStyle(color: Colors.black),
                          decoration: CustomInputs.loginInputDecoration(
                              errorText: state.quantityGranel.invalid
                                  ? 'Ingrese solo números y una cantidad mayor a 0'
                                  : null,
                              hint: 'Ingrese la cantidad que necesita',
                              label: 'Gramos',
                              icon: Icons.calculate_rounded),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: CounterProductWidget(
                          quantity: state.quantityUnits.toInt(),
                          addFunction: () =>
                              context.read<DeatailCubit>().addProductQuatity(),
                          removeFunction: () => context
                              .read<DeatailCubit>()
                              .removeProductQuatity()),
                    );
            },
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<DeatailCubit, DetailState>(
                builder: (context, state) {
                  final price = state.productApi.itemGroup == 'GRANEL'
                      ? (state.productApi.listPrice / 1000)
                      : state.productApi.listPrice;
                  return state.productApi.itemGroup == 'GRANEL'
                      ? ElevatedButton(
                          child: Text('AGREGAR'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.cyan, minimumSize: Size(700, 50)),
                          onPressed: state.quantityGranel.valid
                              ? () {
                                  final quatity =
                                      state.productApi.itemGroup == 'GRANEL'
                                          ? double.parse(
                                                  state.quantityGranel.value) /
                                              1000
                                          : state.quantityUnits;
                                  final double montoIva =
                                      state.productApi.listPrice
                                          * (state.productApi.misc1 / 100);
                                  final _product = Product(
                                      codigoArticulo: state.productApi.code,
                                      cantidad: quatity,
                                      notas: '',
                                      envioParcial: '',
                                      precioSinIva: state.productApi.listPrice,
                                      montoIva: montoIva,
                                      porcentajeIva:
                                          state.productApi.misc1.toDouble(),
                                      codigoTarifa: '',
                                      precioIva:
                                      state.productApi.listPrice + montoIva,
                                      porcentajeDescuento: 0,
                                      montoDescuento: 0,
                                      bonificacion: '',
                                      codImpuesto: state.productApi.misc3);
                                  context.read<ShoppingcartCubit>().addProduct(
                                      CartProduct(
                                          product: _product,
                                          imageUrl: state.productApi.imageUrl,
                                          isGranel:
                                              state.productApi.itemGroup ==
                                                  'GRANEL',
                                          name: state.productApi.name));
                                }
                              : null)
                      : ElevatedButton(
                          child: Text('AGREGAR'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.cyan, minimumSize: Size(700, 50)),
                          onPressed: () {
                            final quatity =
                                state.productApi.itemGroup == 'GRANEL'
                                    ? double.parse(state.quantityGranel.value) /
                                        1000
                                    : state.quantityUnits;
                            final double montoIva =
                                price * (state.productApi.misc1 / 100);
                            final _product = Product(
                                codigoArticulo: state.productApi.code,
                                cantidad: quatity,
                                notas: '',
                                envioParcial: '',
                                precioSinIva: price,
                                montoIva: montoIva,
                                porcentajeIva:
                                    state.productApi.misc1.toDouble(),
                                codigoTarifa: '',
                                precioIva: price + montoIva,
                                porcentajeDescuento: 0,
                                montoDescuento: 0,
                                bonificacion: '',
                                codImpuesto: state.productApi.misc3);
                            context.read<ShoppingcartCubit>().addProduct(
                                CartProduct(
                                    product: _product,
                                    imageUrl: state.productApi.imageUrl,
                                    isGranel:
                                        state.productApi.itemGroup == 'GRANEL',
                                    name: state.productApi.name));
                          });
                },
              )),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 24, bottom: 24),
            child: isMobileAndTablet(context)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _createInfo(
                          Icons.local_shipping, 'Servicio de envío', context),
                      SizedBox(
                        width: 5,
                      ),
                      _createInfo(Icons.smartphone_rounded,
                          'Te avisamos antes de que llegue', context)
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _createInfo(
                          Icons.local_shipping, 'Servicio de envío', context),
                      SizedBox(
                        width: 30,
                      ),
                      _createInfo(Icons.smartphone_rounded,
                          'Te avisamos antes de que llegue', context)
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget _createInfo(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.green[200],
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(text,
            textScaleFactor: isDesktop(context) ? 0.8 : 0.7,
            style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25)),
      ],
    );
  }
}
