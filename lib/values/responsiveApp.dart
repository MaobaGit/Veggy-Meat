import 'package:flutter/material.dart';
import 'package:veggy/util/sizingInfo.dart';

import 'edgeInsetsApp.dart';

class ResponsiveApp {
  late BuildContext _context;
  late MediaQueryData _mediaQueryData;
  late double _textScaleFactor; // para el tamaño del texto
  late double _scaleFactor; // para el tamaño de ja pantalla
  late EdgeInsetsApp edgeInsetsApp;

  ResponsiveApp(this._context){
    _mediaQueryData = MediaQuery.of(_context);
    _textScaleFactor = _mediaQueryData.textScaleFactor;
    // La escala nos dice en que dispositivo estamos y cuanto hay que aumentar el tamaño
    _scaleFactor = isMobile(_context)?1:isTablet(_context)?1.1:1.3;
    edgeInsetsApp=EdgeInsetsApp(this);
  }
//-------------------------------------------------------------
//          Tamaños de todos los objetos de la aplicación     -
//Container                                                   -
  get menuContainerHeight=>setHeight(100);//                  -
  get menuContainerWidth=>setWidth(110);//                    -
  get productContainerWidth=>setWidth(60);//                  -
  get carouselContainerWidth=>setWidth(300);//                -
  get carouselContainerHeight=>setHeight(60);//               -
  get carouselCircleContainerWidth=>setWidth(10);//           -
  get carouselCircleContainerHeight=>setHeight(10);//         -
  get menuTabContainerHeight=>setHeight(400);//               -
  get sectionHeight=>setHeight(50);//                         -
  get sectionWidth=>setWidth(8);//                            -
  get imageContainerHeight=>setHeight(180);//                 -
  get imageContainerwidth=>setWidth(300);//                   -
//                                                            -
//Radius                                                      -
  get menuRadiusWidth=>setWidth(30);//                        -
  get carouselRadiusWidth=>setWidth(10);//                    -
  get containerRadiusWidth=>setWidth(15);//                        -
//                                                            -
//                                                            -
//Images                                                      -
  get menuImageHeight=>setHeight(100);//                       -
  get menuImageWidth=>setWidth(100);//                         -
  get tabImageHeight=>setHeight(30);//                        -
//                                                            -
  get menuHeight=>setHeight(850);//                           -
  get opacityHeight=>setHeight(252);//                        -
  get drawerWidth=>setWidth(252);//                           -
//                                                            -
//Divider and Line                                            -
  get dividerVtlHeight=>setHeight(100);//                     -
  get dividerVtlWidth=>setWidth(2);//                         -
  get dividerHznHeight=>setHeight(1);//                       - 
  get lineHznButtonHeight=>setHeight(2);//                    -
  get lineHznButtonWidth=>setWidth(20);//                     -
//Spaces                                                      -
  get barSpace1Width=>setWidth(60);//                         -
  get barSpace2Width=>setWidth(80);//                         -
//                                                            -
//Text Size                                                   -
  get bodyText1=>setSp(12);//                                 -
  get headline6=>setSp(15);//                                 -
  get headline3=>setSp(30);//                                 - 
  get headline2=>setSp(40);//                                 -
//                                                            -
//Spacing                                                     -
  get letterSpacingCarouselWidth=>setWidth(10);//             -
  get letterSpacingHeaderWidth=>setWidth(3);//                -
//-------------------------------------------------------------


  setWidth(int width) => width * _scaleWidth; // establece el ancho del dispositivo

  setHeight(int height) => height * _scaleHeight; // establece el alto del dispositivo

  
  setSp(int fontSize) =>
      setWidth(fontSize) * _textScaleFactor; // establece el tamaño del texto

  get _scaleWidth => (width * _scaleFactor) / width; // Calcula el ancho del dispositivo

  get _scaleHeight => (height * _scaleFactor) /height; // Calcula el alto del dispositivo

  get width =>_mediaQueryData.size.width; // Obtener el ancho de la pantalla
  get height =>_mediaQueryData.size.height; // obtener el alto de la pantalla
}