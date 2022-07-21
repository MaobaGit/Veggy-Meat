import 'package:flutter/material.dart';
import 'package:veggy/data/production/repositories/banner_repository.dart';
import 'package:veggy/ui/pages/homepage/cubits/carouselCubit/carousel_cubit.dart';
import 'package:veggy/util/sizingInfo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/ui/widgets/carousel.dart';
import 'package:veggy/ui/widgets/bottomBar.dart';
import 'package:veggy/values/responsiveApp.dart';
import 'package:veggy/ui/pages/homepage/widgets/showImage.dart';
import 'package:veggy/ui/pages/homepage/widgets/newProductsView.dart';
import 'package:veggy/ui/pages/homepage/widgets/listCategoryView.dart';
import 'package:veggy/ui/pages/homepage/cubits/newProductsCubit/new_products_cubit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = new ScrollController();
  ResponsiveApp? responsiveApp;
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => NewProductsCubit()..loadNewProducts(),),
        BlocProvider(create: (context) => CarouselCubit(BannerRepository())..getBannersList(),),
        //BlocProvider(create: (context) => CarouselCubit(BannerRepository())..getFeaturedList(),),      
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        /*drawer: ,*/
        body: Scrollbar(
          child: ListView(
            children: [
              Carousel(),
              ListCategoryView(),
              ShowImage(),
              NewProductsView(),
              SizedBox(height: 20,),
              isDesktop(context)? BottomBar(): Container(),
            ],
          ),
        ),
      ),
    );
  }
}
