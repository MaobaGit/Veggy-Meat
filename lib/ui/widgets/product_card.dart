import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:veggy/ui/widgets/outline_custom_buttom.dart';
import 'package:veggy/util/sizingInfo.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {required this.title,
      required this.price,
      required this.code,
      required this.category,
      required this.imageUrl,
      required this.unidad,
      required this.onPressCard,
      required this.onPressButton})
      : super();
  final String title;
  final String price;
  final String code;
  final String category;
  final String imageUrl;
  final String unidad;
  final VoidCallback onPressCard;
  final VoidCallback onPressButton;
  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return InkWell(
      radius: 8.0,
      onTap: onPressCard,
      child: Card(
        elevation: 1,
        margin: EdgeInsets.only(left: 10, top:10, right: 10, bottom:10),
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: imageUrl.isNotEmpty
                  ? FadeInImage(
                      placeholder:
                          AssetImage('assets/icons/Pulse-1s-200px.gif'),
                      image: NetworkImage(imageUrl))
                  : Image.asset('assets/images/imagen_no_disponible.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 150,
              child: Text(
                
                title,
                textAlign: TextAlign.center,
                style: themeText.bodyText1,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            !isMobile(context)? Text('Codigo:$code', style: themeText.overline):Container(),
            SizedBox(
              height:!isMobile(context)? 5:0,
            ),
             !isMobile(context)?Text('Categoria:$category', style: themeText.overline):Container(),
            SizedBox(
              height: !isMobile(context)? 5:0,
            ),
             !isMobile(context)?Text('Unidad de medida:$unidad', style: themeText.overline):Container(),
            SizedBox(
              height: !isMobile(context)? 5:0,
            ),
            Text(
              'CRC $price',
              style: themeText.subtitle1,
            ),
            SizedBox(
              height: 10,
            ),
            CustomOutlinedButton(
              onPressed: onPressButton,
              text: 'Agregar',
              color: Colors.green,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
