part of 'departmentFilter_cubit.dart';

/**
 * Clase de estado de la vista por departamentos para almacenar su
 * información. Posee una lista de objetos ProductApi como la lista de
 * productos a mostrar, la categoría actual seleccionada por el usuario,
 * el valor del último elemento de cada lista y el valor de búsqueda, en
 * caso de que se busquen productos por nombre.
 */
class DepartmentFilterState extends Equatable {

  final List<ProductApi> listProducts;
  String currentCategory;
  String lastElements;
  String searchString;

  DepartmentFilterState(
      {this.listProducts = const [], this.currentCategory = 'FRUTASVERDURAS', this.lastElements = '', this.searchString = ''});

  DepartmentFilterState copyWith(
      {List<ProductApi>? listProducts, String? currentCategory, String? lastElements, String? searchString}) {
    return DepartmentFilterState(
        listProducts: listProducts ?? this.listProducts,
        currentCategory: currentCategory ?? this.currentCategory,
        lastElements: lastElements ?? this.lastElements,
        searchString: searchString ?? this.searchString
    );
  }

  @override
  List<Object> get props => [listProducts, currentCategory, lastElements, searchString];
}
