import 'package:flutter/material.dart';
import 'package:veggy/values/responsiveApp.dart';

class FeaturedCArd extends StatelessWidget {
  const FeaturedCArd({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    ResponsiveApp responsiveApp = ResponsiveApp(context);
    return Container(
      width: responsiveApp.imageContainerwidth,
      height: responsiveApp.imageContainerHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(responsiveApp.containerRadiusWidth)),
          border: Border.all(color: Colors.white)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Image(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
