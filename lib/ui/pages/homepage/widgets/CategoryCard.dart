import 'package:flutter/material.dart';
import 'package:veggy/values/responsiveApp.dart';
import 'package:veggy/domain/models/category.dart';
import 'package:websafe_svg/websafe_svg.dart';
//** Modelo de las tajetas que se usa para las categorias de la apágina de inicio*/
class CategoryCard extends StatefulWidget {
  const CategoryCard({ Key? key, required this.index, required this.onPress }) : super(key: key);
  final int index;
  final VoidCallback onPress;
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  late ResponsiveApp responsiveApp;
  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Padding(
      padding: responsiveApp.edgeInsetsApp.hrzSmallEdgeInsets,
      child: InkWell(
        onTap: widget.onPress,
        child: Container(
          width: responsiveApp.menuContainerWidth,
          height: responsiveApp.menuContainerHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(responsiveApp.menuRadiusWidth))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WebsafeSvg.asset(
              categories[widget.index].image!,
              width: responsiveApp.menuImageWidth,
              height: responsiveApp.menuImageHeight,
              fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    );
  }
}