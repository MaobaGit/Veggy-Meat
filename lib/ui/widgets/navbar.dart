import 'package:flutter/material.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/router/routes.dart';
import 'package:veggy/ui/widgets/cart_shopping_icon.dart';
import 'package:veggy/ui/widgets/search_text.dart';
import 'package:veggy/util/sizingInfo.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          isMobileAndTablet(context)
              ? IconButton(
                  icon: Icon(
                    Icons.home_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    NavigationService.navigateTo(Flurorouter.rootRoute);
                  })
              : Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: TextButton(
                      onPressed: () {
                        NavigationService.navigateTo(Flurorouter.rootRoute);
                      },
                      child: WebsafeSvg.asset(
                        'assets/icons/LOGO_VEGGY_PRINCIPAL.svg',
                        height: 70,
                        width: 70,
                      )),
                ),

          Expanded(child: Container()),

          // Search input
          //if (!isMobileAndTablet(context))
          //  ConstrainedBox(
          //    constraints: BoxConstraints(maxWidth: 550),
          //    child: SearchText(),
          //  ),

          Spacer(),

          Row(
            children: [
              Text(
                'Contáctenos:\n+506 8939 5313',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 5.0),
              WebsafeSvg.asset(
                'assets/icons/whatsapplogo.svg',
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              ),
            ],
          ),
          SizedBox(width: 10),
          IconCartShoppingIndicator(),
          SizedBox(width: 24)
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: Colors.black,
      boxShadow: [BoxShadow(color: Colors.white, blurRadius: 5)]);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
