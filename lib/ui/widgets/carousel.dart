import 'package:veggy/ui/pages/homepage/cubits/carouselCubit/carousel_cubit.dart';
import 'package:veggy/domain/models/carouselModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:veggy/values/responsiveApp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/util/sizingInfo.dart';
import 'package:flutter/material.dart';

//** Carrousel de la página de inicio*/
class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  ResponsiveApp? responsiveApp;

  @override
  Widget build(BuildContext context) { 
    responsiveApp = ResponsiveApp(context);
    return Body(responsiveApp!);   
  }
}

class Body extends StatefulWidget {
  Body(this.responsiveApp) : super();
  final ResponsiveApp responsiveApp;
  @override
  _BodyState createState() => _BodyState(responsiveApp);
}

class _BodyState extends State<Body> {
  _BodyState(this.responsiveApp);
  final CarouselController _controller = CarouselController();
  final ResponsiveApp responsiveApp;
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselCubit, CarousellState>(
        builder: (context, state) {
      var imageSliders = generateImageTiles(state.bannersList);
      return Stack(
        children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                scrollPhysics: isMobileAndTablet(context)
                    ? PageScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 28 / 8,
                onPageChanged: (index, reason) {
                  context.read<CarouselCubit>().currentChange(index);
                  //se utiliza para saber cual imagen esta selecionada
                  setState(() {
                    _current = index;
                  });
                }),
            carouselController: _controller,
          ),
          isMobileAndTablet(context)
              ? Container()
              : Positioned.fill(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: responsiveApp.carouselContainerWidth,
                        height: responsiveApp.carouselContainerHeight,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // se generan los puntitos de cada imagen en el carousel
                            children: List.generate(
                              imageSliders.length,
                              (index) => InkWell(
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    _controller.animateToPage(index);
                                  },
                                  //tamaño y forma de cada puntito en el carrusel
                                  child: Container(
                                    width: responsiveApp
                                        .carouselCircleContainerWidth,
                                    height: responsiveApp
                                        .carouselCircleContainerHeight,
                                    margin: responsiveApp
                                        .edgeInsetsApp.allSmallEdgeInsets,
                                    decoration: BoxDecoration(
                                        color: _current == index
                                            ? Colors.white
                                            : Colors.blueGrey,
                                        shape: BoxShape.circle),
                                  )),
                            )),
                      )))
        ],
      );
    });
  }

  //Se envuelve en un widget cada imagen de firebase para mostrar en el carrousel
  //y poder generar un borde circular a cada imagen
  //@ Params : List<CarouselModel> bannersList, lista de imagenes
  //@ Return : List<Widget>, lista de imagenes envueltas en el widget
  List<Widget> generateImageTiles(List<CarouselModel> bannersList) {
    return bannersList
        .map(
          (element) => ClipRRect(
            borderRadius:
                BorderRadius.circular(responsiveApp.carouselRadiusWidth),
            child:
                Image(image: NetworkImage(element.image!), fit: BoxFit.cover),
          ),
        )
        .toList();
  }
}
