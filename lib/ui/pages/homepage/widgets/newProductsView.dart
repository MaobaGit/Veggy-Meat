import 'package:flutter/material.dart';
import 'package:veggy/domain/models/product_detail.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/util/sizingInfo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/domain/models/product.dart';
import 'package:veggy/ui/widgets/product_card.dart';
import 'package:veggy/domain/models/cart_product.dart';
import 'package:veggy/ui/ShoppingCartCubit/shoppingcart_cubit.dart';
import 'package:veggy/ui/pages/homepage/cubits/newProductsCubit/new_products_cubit.dart';

//**Esta clase lee desde el state la lista de productos nuevos
//y los muestra en el home en una tarjeta con su respectiva informacion*/
class NewProductsView extends StatelessWidget {
  const NewProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Body();
  }
}

class _Body extends StatelessWidget {
  final ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Titulo de la seccion de los productos mas nuevos
          Padding(
            padding: EdgeInsets.only(
                top: 24, bottom: 14, left: isMobile(context) ? 20 : 0),
            child: Text(
              'Lo más nuevo',
              style: isMobileAndTablet(context)? Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white) : 
                  Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
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
            child: BlocBuilder<NewProductsCubit, NewProductState>(
              buildWhen: (previous, current) =>
                  previous.listNewProducts != current.listNewProducts,
              builder: (context, state) {
                scrollController.addListener(() {
                  if (scrollController.position.pixels ==
                      scrollController.position.maxScrollExtent) {
                    context.read<NewProductsCubit>().addMore();
                  }
                });
                return Scrollbar(
                  isAlwaysShown: true,
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.listNewProducts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final price =
                          state.listNewProducts[index].itemGroup == 'GRANEL'
                              ? (state.listNewProducts[index].listPrice / 1000)
                              : state.listNewProducts[index].listPrice;
                      return ProductCard(
                          title: state.listNewProducts[index].name,
                          price: (price+(price*(state.listNewProducts[index].misc1 / 100))).toStringAsFixed(2),
                          code: state.listNewProducts[index].code,
                          category: state.listNewProducts[index].itemGroup,
                          imageUrl: state.listNewProducts[index].imageUrl,
                          unidad: state.listNewProducts[index].unidad,
                          onPressCard: () {
                            NavigationService.navigateToWithArguments(
                                'detail/${state.listNewProducts[index].itemGroup}/${state.listNewProducts[index].code}',
                                ProductDetail(
                                    product: state.listNewProducts[index],
                                    sameListProduct: []));
                          },
                          onPressButton: () {
                            final double quatity =
                                      state.listNewProducts[index].itemGroup == 'GRANEL'
                                          ? 1 / 1000
                                          : 1.0;
                            final double montoIva = state.listNewProducts[index].listPrice * (state.listNewProducts[index].misc1 / 100);
                            final _product = Product(
                                codigoArticulo:
                                    state.listNewProducts[index].code,
                                cantidad: quatity,
                                notas: '',
                                envioParcial: '',
                                precioSinIva: state.listNewProducts[index].listPrice,
                                montoIva: montoIva,
                                porcentajeIva: state
                                    .listNewProducts[index].misc1
                                    .toDouble(),
                                codigoTarifa: '',
                                precioIva: state.listNewProducts[index].listPrice + montoIva,
                                porcentajeDescuento: 0,
                                montoDescuento: 0,
                                bonificacion: '',
                                codImpuesto:
                                    state.listNewProducts[index].misc3);
                            context.read<ShoppingcartCubit>().addProduct(
                                CartProduct(
                                    product: _product,
                                    imageUrl:  state.listNewProducts[index].imageUrl,
                                    isGranel: state
                                            .listNewProducts[index].itemGroup ==
                                        'GRANEL',
                                    name: state.listNewProducts[index].name +
                                        '2'));
                          });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
