import 'package:flutter/material.dart';
import 'package:veggy/values/responsiveApp.dart';

class EdgeInsetsApp {
  //Todo el margen o widget
  late EdgeInsets allSmallEdgeInsets;
  late EdgeInsets allMediumEdgeInsets;
  late EdgeInsets allLargeEdgeInsets;
  late EdgeInsets allExLargeEdgeInsets;
  //Vertical
  late EdgeInsets vrtSmallEdgeInsets;
  late EdgeInsets vrtMediumEdgeInsets;
  late EdgeInsets vrtLargeEdgeInsets;
  late EdgeInsets vrtExLargeEdgeInsets;
  // Horizontal
  late EdgeInsets hrzMediumEdgeInsets;
  late EdgeInsets hrzSmallEdgeInsets;
  late EdgeInsets hrzLargeEdgeInsets;

  //Solo derecha, izquierda, arriba y abajo SMALL
  late EdgeInsets onlySmallTopEdgeInsets;
  late EdgeInsets onlySmallBottomEdgeInsets;
  late EdgeInsets onlySmallRightEdgeInsets;
  late EdgeInsets onlySmallLeftEdgeInsets;

  //Solo derecha, izquierda, arriba y abajo MEDIUM
  late EdgeInsets onlyMediumTopEdgeInsets;
  late EdgeInsets onlyMediumBottomEdgeInsets;
  late EdgeInsets onlyMediumRightEdgeInsets;
  late EdgeInsets onlyMediumLeftEdgeInsets;

  //Solo derecha, izquierda, arriba y abajo LARGE
  late EdgeInsets onlyLargeTopEdgeInsets;
  late EdgeInsets onlyLargeBottomEdgeInsets;
  late EdgeInsets onlyLargeRightEdgeInsets;
  late EdgeInsets onlyLargeLeftEdgeInsets;

  // Solo arriba
  late EdgeInsets onlyExLargeTopEdgeInsets;

// Instancia de responsiveApp
  late ResponsiveApp _responsiveApp;

// obtenemos el ancho y largo del dispositivo
// aquí nos damos cuenta si es movil, tablet o escritorio.
  EdgeInsetsApp(this._responsiveApp){

    //Padding en pixeles
    //Mobile
    double _smallHeightEdgeInsets =_responsiveApp.setHeight(5);
    double _smallWidthEdgeInsets =_responsiveApp.setWidth(5);
    //tablet
    double  _mediumHeightEdgeInsets =_responsiveApp.setHeight(10);
    double  _mediumWidthEdgeInsets =_responsiveApp.setWidth(10);
    //Escritorio
    double  _largeHeightEdgeInsets =_responsiveApp.setHeight(20);
    double  _largeWidthEdgeInsets =_responsiveApp.setWidth(20);

    double  _largeExHeightEdgeInsets =_responsiveApp.setHeight(50);
    double  _largeExWidthEdgeInsets =_responsiveApp.setWidth(50);

    //Todo los lados 
    allSmallEdgeInsets =
        EdgeInsets.symmetric(vertical: _smallHeightEdgeInsets,
            horizontal: _smallWidthEdgeInsets);
    allMediumEdgeInsets =
        EdgeInsets.symmetric(vertical:_mediumHeightEdgeInsets,
            horizontal: _mediumWidthEdgeInsets);
    allLargeEdgeInsets =
        EdgeInsets.symmetric(vertical: _largeHeightEdgeInsets,
            horizontal: _largeWidthEdgeInsets);
    allExLargeEdgeInsets =
        EdgeInsets.symmetric(vertical: _largeExHeightEdgeInsets,
            horizontal: _largeExWidthEdgeInsets);


    //Vertical mode
    vrtSmallEdgeInsets =
        EdgeInsets.symmetric(vertical: _smallHeightEdgeInsets);
    vrtMediumEdgeInsets =
        EdgeInsets.symmetric(vertical: _mediumHeightEdgeInsets);
    vrtLargeEdgeInsets =
        EdgeInsets.symmetric(vertical: _largeHeightEdgeInsets);
    vrtExLargeEdgeInsets =
        EdgeInsets.symmetric(vertical: _largeExHeightEdgeInsets);


    // Horizontal mode
    hrzMediumEdgeInsets =
        EdgeInsets.symmetric(horizontal: _mediumWidthEdgeInsets);
    hrzSmallEdgeInsets =
        EdgeInsets.symmetric(horizontal:_smallWidthEdgeInsets);
    hrzLargeEdgeInsets =
        EdgeInsets.symmetric(horizontal: _largeWidthEdgeInsets);

    //Solo derecha, izquierda, arriba y abajo SMALL
    onlySmallTopEdgeInsets =
        EdgeInsets.only(top: _smallHeightEdgeInsets);
    onlySmallBottomEdgeInsets =
        EdgeInsets.only(bottom: _smallHeightEdgeInsets);
    onlySmallRightEdgeInsets =
        EdgeInsets.only(right: _smallWidthEdgeInsets);
    onlySmallLeftEdgeInsets =
        EdgeInsets.only(left: _smallWidthEdgeInsets);

    //Solo derecha, izquierda, arriba y abajo MEDIUM
    onlyMediumTopEdgeInsets =
        EdgeInsets.only(top: _mediumHeightEdgeInsets);
    onlyMediumBottomEdgeInsets =
        EdgeInsets.only(bottom: _mediumHeightEdgeInsets);
    onlyMediumRightEdgeInsets =
        EdgeInsets.only(right: _mediumWidthEdgeInsets);
    onlyMediumLeftEdgeInsets =
        EdgeInsets.only(left: _mediumWidthEdgeInsets);

    //Solo derecha, izquierda, arriba y abajo LARGE
    onlyLargeTopEdgeInsets =
        EdgeInsets.only(top: _largeHeightEdgeInsets);
    onlyLargeBottomEdgeInsets =
        EdgeInsets.only(bottom: _largeHeightEdgeInsets);
    onlyLargeRightEdgeInsets =
        EdgeInsets.only(right: _largeWidthEdgeInsets);
    onlyLargeLeftEdgeInsets =
        EdgeInsets.only(left: _largeWidthEdgeInsets);

    //Solo arriba
    onlyExLargeTopEdgeInsets =
        EdgeInsets.only(top: _largeExHeightEdgeInsets);

  }
}