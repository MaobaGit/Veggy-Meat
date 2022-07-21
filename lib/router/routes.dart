import 'dart:convert';

import 'package:fluro/fluro.dart';

import 'package:veggy/domain/models/product_detail.dart';
import 'package:veggy/ui/pages/404page/notfound_page.dart';
import 'package:veggy/ui/pages/detail/detail_page.dart';
import 'package:veggy/ui/pages/formpage/form_preorder_page.dart';
import 'package:veggy/ui/pages/homepage/homePage.dart';
import 'package:veggy/ui/pages/department_filter/department_filter_page.dart';
import 'package:veggy/ui/pages/shopping%20cart/shoppingCart.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();
  static String rootRoute = '/';
  static String detailRoute = '/detail/:category/:id';
  static String homeRoute = '/home';
  static String formPreOrderRoute = '/preorder';
  static String departmentFilterRoute = '/departmentFilter/:category';
  static String shoppingCartRoute = '/shoppingCart';

  static Handler _detailHandler = Handler(handlerFunc: (context, parameters) {
    final String id = parameters['id']![0];
    final String category = parameters['category']![0];
    try {
      final _product = context!.settings!.arguments as ProductDetail;
      return DetailPage(
        product: _product,
        productId: id,
        category: category,
      );
    } catch (e) {
      return DetailPage(
        product: null,
        productId: id,
        category: category,
      );
    }
  });
  static Handler _homeHandler =
      Handler(handlerFunc: (context, parameters) => HomePage());
  static Handler _notFoundHandler =
      Handler(handlerFunc: (context, parameters) => NoPageFoundPage());
  static Handler _formPreOrderHandler =
      Handler(handlerFunc: (context, parameters) => FormPreorderPage());
  static Handler _departmentFilterHandler =
      Handler(handlerFunc: (context, parameters) {
        try {
          final String category = parameters['category']![0];
          return DepartmentFilterPage(currentDepartment: category);
        } catch (e) {
          return DepartmentFilterPage(currentDepartment: "FRUTASVERDURAS");
        }
      });
  static Handler _shoppingCartHandler =
      Handler(handlerFunc: (context, parameters) => ShoppingCart());

  static void setupRouter() {
    router.define(rootRoute,
        handler: _homeHandler, transitionType: TransitionType.none);
    router.define(detailRoute,
        handler: _detailHandler, transitionType: TransitionType.none);
    router.define(formPreOrderRoute,
        handler: _formPreOrderHandler, transitionType: TransitionType.fadeIn);
    router.define(formPreOrderRoute,
        handler: _formPreOrderHandler, transitionType: TransitionType.fadeIn);
    router.define(formPreOrderRoute,
        handler: _formPreOrderHandler, transitionType: TransitionType.none);
    router.define(departmentFilterRoute,
        handler: _departmentFilterHandler, transitionType: TransitionType.none);
    router.define(shoppingCartRoute,
        handler: _shoppingCartHandler, transitionType: TransitionType.none);

    router.notFoundHandler = _notFoundHandler;
  }

  static Map<String, dynamic> decodeJsonDataForFluro(String encodedMap) {
    return jsonDecode(encodedMap.replaceAll(HtmlEscape().convert("/"), "/"));
  }

  static String encodeJsonDataForFluro(Map<String, dynamic> mapToEncode) {
    return jsonEncode(mapToEncode).replaceAll("/", HtmlEscape().convert("/"));
  }
}
