import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/domain/models/carouselModel.dart';
import 'package:veggy/data/production/repositories/banner_repository.dart';

part 'carousel_State.dart';

//** Esta clase representa el patron Cubit para manejar la lógica del carrousel*/
class CarouselCubit extends Cubit<CarousellState> {
  CarouselCubit(this.bannerRepository) : super(CarousellState(bannersList: []));
  final BannerRepository bannerRepository;
  // sin uso
  void isSelectedChange(List<CarouselModel> list) {
    emit(state.copyWith(bannersList: list));
  }

  // sin uso
  void currentChange(int index) {
    emit(state.copyWith(current: index));
  }

  //** Obtiene la lista de imagenes para presentar en el carrousel de la
  //página de inicio, si la lista viene vacia, se guarda en la nueva lista
  //la imagen principal de veggy por defecto guardada en este proyecto
  //la lista se actualiza en el state, para acceder a ella se hacer por medio
  //del state.bannersList por medio del bloc builder.
  //return : void
  //params : no arguments */
  void getBannersList() async {
    getFeaturedList();
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      List<CarouselModel> bannersList =
          await bannerRepository.allBannersImages();
      if (bannersList.isEmpty == true) {
        bannersList.add(new CarouselModel(
            image: 'assets/images/Portada veggy - 28 abril 2021 v03.png',
            index: 0,
            isSelected: true));
      }
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, bannersList: bannersList));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
  //** Obtiene la lista de imagenes para presentar en la sección de destacados de la
  //página de inicio, si la lista viene vacia, añade en la nueva lista
  //la imagen principal de veggy por defecto guardada en este proyecto
  //la lista se actualiza en el state, para acceder a ella se hacer por medio
  //del state.listFeatured por medio del bloc builder.
  //return : void
  //params : no arguments */
  void getFeaturedList() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      List<String> featuredList = await bannerRepository.allFeaturedImages();
      if (featuredList.isEmpty == true) {
        featuredList.add(
          'assets/images/veggy-banner.png',
        );
      }
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, listFeatured: featuredList));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
