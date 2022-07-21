import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:veggy/domain/models/product_api.dart';
import 'package:veggy/data/production/repositories/product_repository.dart';

part 'new_products_state.dart';

class NewProductsCubit extends Cubit<NewProductState> {
  NewProductsCubit() : super(NewProductState());
  late ProductRepository _productRepository;
  
  //** Este método agrega más productos a la lista del state para mostrar 
  //cuando el usuario llega hasta el final del scroll en la página de inicio 
  //@Params : No aplica
  //@Returns : No aplica*/
  void addMore() async {
    final tempList;
    tempList = await _productRepository.getProductsByCategory('ABARROTES', state.listNewProducts.last.code);
    emit(state.copyWith(
          listNewProducts: state.listNewProducts + tempList));
 }
  //** Este metodo carga productos de categorias al azar para 
  //mostrar en la lista de lo mas nuevo y los guarda en la lista del state.
  //@Params : no aplica
  //Returns : no aplica*/
  void loadNewProducts() async {
    List<ProductApi> list = [];
    _productRepository = ProductRepository();
    list = await _productRepository.getProductsByCategory('ABARROTES', null);
    emit(state.copyWith(
        listNewProducts: list));
  }
}
