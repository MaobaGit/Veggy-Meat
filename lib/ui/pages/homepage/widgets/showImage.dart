import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/ui/pages/homepage/cubits/carouselCubit/carousel_cubit.dart';
import 'package:veggy/ui/pages/homepage/widgets/featuredCard.dart';
import 'package:veggy/util/sizingInfo.dart';
import 'package:veggy/values/responsiveApp.dart';

class ShowImage extends StatefulWidget {
  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  late ResponsiveApp responsiveApp;
  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return BlocBuilder<CarouselCubit, CarousellState>(
      builder: (context, state) {
        return Padding(
          padding: responsiveApp.edgeInsetsApp.allLargeEdgeInsets,
          // Si la aplicación corre en un dispositivo movil o tablet se muestra
          // una columna con las imagenes sino se muestra en forma de fila.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: responsiveApp.edgeInsetsApp.allSmallEdgeInsets,
                child: Text(
                  'Destacado',
                  style: isMobileAndTablet(context)
                      ? Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)
                      : Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Padding(
                padding: responsiveApp.edgeInsetsApp.allExLargeEdgeInsets,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 10,
                  children: List.generate(
                      state.listFeatured.length,
                      (index) =>
                          FeaturedCArd(image: state.listFeatured[index])),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
