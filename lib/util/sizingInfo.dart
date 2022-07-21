import 'package:flutter/material.dart';

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < tabletSmall;
}

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= tabletSmall &&
      MediaQuery.of(context).size.width <= tabletExtraLarge;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > tabletExtraLarge;
}

bool isMobileAndTablet(context) {
  return MediaQuery.of(context).size.width <= tabletExtraLarge; 
}

//Mobile size in pixeles
double get mobileSmall => 320;

double get mobileNormal => 375;

double get mobileLarge => 414;

double get mobileExtraLarge => 480;

//table size in pixeles
double get tabletSmall => 600;

double get tabletNormal => 768;

double get tabletLarge => 850;

double get tabletExtraLarge => 900;

//desktop size in pixeles
double get desktopSmall => 950;

double get desktopNormal => 1920;

double get desktopLarge => 3840;

double get desktopExtraLarge => 4096;