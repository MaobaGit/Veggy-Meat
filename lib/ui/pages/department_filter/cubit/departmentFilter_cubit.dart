import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:veggy/domain/models/product_api.dart';
import 'package:veggy/domain/usecases/products_usecase.dart';
part 'departmentFilter_state.dart';

/**
 * Clase de tipo Cubit para manejo de estado de la seccion de vista
 * por departamentos. Posee un ProductUseCase para solicitar información
 * de la base de datos.
 */
class DepartmentFilterCubit extends Cubit<DepartmentFilterState> {

  DepartmentFilterCubit() : super(DepartmentFilterState());
  final _productUseCase = ProductUseCase();

  /**
   * Función para agregar productos a la lista del estado. Solicita
   * la lista a la función categorySwitchSearch() y actualiza el
   * estado con esta lista.
   */
  Future<String> addProducts() async{
    final tempList;
    tempList = await categorySwitchSearch();
    emit(state.copyWith(listProducts: state.listProducts + tempList));
    return "";
  }

  /**
   * Función encargada de devolver la lista de productos de la
   * categoría actualmente seleccionada en el estado. Si el estado
   * tiene un valor para el último elemento, agrega a la lista actual del
   * estado más productos apartir de este último elemento.
   * @Return : Future<List<ProductApi>>
   * Lista de productos obtenida.
   */
  Future<List<ProductApi>> categorySwitchSearch() async {

    List<ProductApi> tempList = [];
    List<String> subCodes = [];
    if (state.lastElements.isNotEmpty){
      subCodes = state.lastElements.split(":");
    }
    switch(state.currentCategory) {
      case "FRUTASVERDURAS": {
        List<ProductApi> listFrutas1 = [];
        List<ProductApi> listFrutas2 = [];
        List<ProductApi> listVerduras = [];
        List<ProductApi> listTuberculos = [];
        List<ProductApi> listLegumbres = [];
        if (state.lastElements.isNotEmpty){
          listFrutas1 = await _productUseCase.getProductsByCateforie('FRUTAS NACIONALES', subCodes[0]);
          listFrutas2 = await _productUseCase.getProductsByCateforie('FRUTAS INTERNACIONALES', subCodes[1]);
          listVerduras = await _productUseCase.getProductsByCateforie('VERDURAS', subCodes[2]);
          listTuberculos = await _productUseCase.getProductsByCateforie('TUBERCULOS', subCodes[3]);
          listLegumbres = await _productUseCase.getProductsByCateforie('LEGUMBRES', subCodes[4]);
        } else {
          listFrutas1 = await _productUseCase.getProductsByCateforie('FRUTAS NACIONALES', null);
          listFrutas2 = await _productUseCase.getProductsByCateforie('FRUTAS INTERNACIONALES', null);
          listVerduras = await _productUseCase.getProductsByCateforie("VERDURAS", null);
          listTuberculos = await _productUseCase.getProductsByCateforie("TUBERCULOS", null);
          listLegumbres = await _productUseCase.getProductsByCateforie("LEGUMBRES", null);
        }

        int n = 0;
        while (n<listFrutas1.length || n<listFrutas2.length || n<listVerduras.length || n<listTuberculos.length || n<listLegumbres.length) {
          if(n<listFrutas1.length && verifyList(listFrutas1[n].code)){
            tempList.add(listFrutas1[n]);
          }
          if(n<listFrutas2.length && verifyList(listFrutas2[n].code)){
            tempList.add(listFrutas2[n]);
          }
          if(n<listVerduras.length && verifyList(listVerduras[n].code)){
            tempList.add(listVerduras[n]);
          }
          if(n<listTuberculos.length && verifyList(listTuberculos[n].code)){
            tempList.add(listTuberculos[n]);
          }
          if(n<listLegumbres.length && verifyList(listLegumbres[n].code)){
            tempList.add(listLegumbres[n]);
          }
          n++;
        }
        String newLast = getLastCode(listFrutas1) + ":";
        newLast += getLastCode(listFrutas2) + ":";
        newLast += getLastCode(listVerduras) + ":";
        newLast += getLastCode(listTuberculos) + ":";
        newLast += getLastCode(listLegumbres) + ":";
        state.lastElements == newLast;
      }
      break;
      case "CARNICERIA": {
        List<ProductApi> listCarneRes = [];
        List<ProductApi> listCarneCerdo = [];
        List<ProductApi> listCarnePollo = [];
        List<ProductApi> listMariscos = [];
        List<ProductApi> listEmbutidos = [];
        if (!state.lastElements.isEmpty){
          listCarneRes = await _productUseCase.getProductsByCateforie('CARNE DE RES', subCodes[0]);
          listCarneCerdo = await _productUseCase.getProductsByCateforie('CARNE DE CERDO', subCodes[1]);
          listCarnePollo = await _productUseCase.getProductsByCateforie('CARNE DE POLLO', subCodes[2]);
          listMariscos = await _productUseCase.getProductsByCateforie('MARISCOS', subCodes[3]);
          listEmbutidos = await _productUseCase.getProductsByCateforie('EMBUTIDOS', subCodes[4]);
        } else {
          listCarneRes = await _productUseCase.getProductsByCateforie('CARNE DE RES', null);
          listCarneCerdo = await _productUseCase.getProductsByCateforie('CARNE DE CERDO', null);
          listCarnePollo = await _productUseCase.getProductsByCateforie('CARNE DE POLLO', null);
          listMariscos = await _productUseCase.getProductsByCateforie('MARISCOS', null);
          listEmbutidos = await _productUseCase.getProductsByCateforie('EMBUTIDOS', null);
        }

        int n = 0;

        while (n<listCarneRes.length || n<listCarneCerdo.length || n<listCarnePollo.length || n<listMariscos.length || n<listEmbutidos.length) {
          if(n<listCarneRes.length && verifyList(listCarneRes[n].code)){
            tempList.add(listCarneRes[n]);
          }
          if(n<listCarneCerdo.length && verifyList(listCarneCerdo[n].code)){
            tempList.add(listCarneCerdo[n]);
          }
          if(n<listCarnePollo.length && verifyList(listCarnePollo[n].code)){
            tempList.add(listCarnePollo[n]);
          }
          if(n<listMariscos.length && verifyList(listMariscos[n].code)){
            tempList.add(listMariscos[n]);
          }
          if(n<listEmbutidos.length && verifyList(listEmbutidos[n].code)){
            tempList.add(listEmbutidos[n]);
          }
          n++;
        }
        String newLast = getLastCode(listCarneRes) + ":";
        newLast += getLastCode(listCarneCerdo) + ":";
        newLast += getLastCode(listCarnePollo) + ":";
        newLast += getLastCode(listMariscos) + ":";
        newLast += getLastCode(listEmbutidos) + ":";
        state.lastElements = newLast;
      }
      break;
      case "GRANEL": {
        List<ProductApi> listGranel = [];
        List<ProductApi> listProcesados = [];
        if (!state.lastElements.isEmpty){
          listGranel = await _productUseCase.getProductsByCateforie('GRANEL', subCodes[0]);
          listProcesados = await _productUseCase.getProductsByCateforie('PROCESADOS', subCodes[1]);
        } else {
          listGranel = await _productUseCase.getProductsByCateforie('GRANEL', null);
          listProcesados = await _productUseCase.getProductsByCateforie('PROCESADOS', null);
        }

        int n = 0;

        while (n<listGranel.length || n<listProcesados.length) {
          if(n<listGranel.length && verifyList(listGranel[n].code)){
            tempList.add(listGranel[n]);
          }
          if(n<listProcesados.length && verifyList(listProcesados[n].code)){
            tempList.add(listProcesados[n]);
          }
          n++;
        }
        String newLast = getLastCode(listGranel) + ":";
        newLast += getLastCode(listProcesados) + ":";
        state.lastElements = newLast;
      }
      break;
      case "ABARROTES": {
        List<ProductApi> listAbarrotes = [];
        List<ProductApi> listLacteos = [];
        if (!state.lastElements.isEmpty){
          listAbarrotes = await _productUseCase.getProductsByCateforie('ABARROTES', subCodes[0]);
          listLacteos = await _productUseCase.getProductsByCateforie('LACTEOS', subCodes[1]);
        } else {
          listAbarrotes = await _productUseCase.getProductsByCateforie('ABARROTES', null);
          listLacteos = await _productUseCase.getProductsByCateforie('LACTEOS', null);
        }

        int n = 0;

        while (n<listAbarrotes.length || n<listLacteos.length) {
          if(n<listAbarrotes.length && verifyList(listAbarrotes[n].code)){
            tempList.add(listAbarrotes[n]);
          }
          if(n<listLacteos.length && verifyList(listLacteos[n].code)){
            tempList.add(listLacteos[n]);
          }
          n++;
        }
        String newLast = getLastCode(listAbarrotes) + ":";
        newLast += getLastCode(listLacteos) + ":";
        state.lastElements = newLast;
      }
      break;
      case "LICORES": {
        List<ProductApi> listLicores = [];
        if (!state.lastElements.isEmpty){
          listLicores = await _productUseCase.getProductsByCateforie('LICORES', subCodes[0]);
          listLicores.addAll(await _productUseCase.getProductsByCateforie('LICORES', listLicores.last.code));
        } else {
          listLicores = await _productUseCase.getProductsByCateforie('LICORES', null);
          listLicores.addAll(await _productUseCase.getProductsByCateforie('LICORES', listLicores.last.code));
        }

        int n = 0;

        while (n<listLicores.length) {
          if(n<listLicores.length && verifyList(listLicores[n].code)){
            tempList.add(listLicores[n]);
          }
          n++;
        }
        String newLast = getLastCode(listLicores) + ":";
        state.lastElements = newLast;
      }
      break;
      case "ACCESORIOS": {
        List<ProductApi> listAccesorios1 = [];
        List<ProductApi> listAccesorios2 = [];
        List<ProductApi> listAccesorios3 = [];
        List<ProductApi> listAccesorios4 = [];
        if (!state.lastElements.isEmpty){
          listAccesorios1 = await _productUseCase.getProductsByCateforie('PRODUCTO TERMINADO FABRICA DE PLASTICO', subCodes[0]);
          listAccesorios2 = await _productUseCase.getProductsByCateforie('ACCESORIOS Y OTROS', subCodes[1]);
          listAccesorios3 = await _productUseCase.getProductsByCateforie('MATERIA PRIMA FABRICA DE PLASTICO', subCodes[2]);
          listAccesorios4 = await _productUseCase.getProductsByCateforie('MATERIA PRIMA LICITACIONES', subCodes[3]);
        } else {
          listAccesorios1 = await _productUseCase.getProductsByCateforie('PRODUCTO TERMINADO FABRICA DE PLASTICO', null);
          listAccesorios2 = await _productUseCase.getProductsByCateforie('ACCESORIOS Y OTROS', null);
          listAccesorios3 = await _productUseCase.getProductsByCateforie('MATERIA PRIMA FABRICA DE PLASTICO', null);
          listAccesorios4 = await _productUseCase.getProductsByCateforie('MATERIA PRIMA LICITACIONES', null);
        }

        int n = 0;

        while (n<listAccesorios1.length || n<listAccesorios2.length || n<listAccesorios3.length || n<listAccesorios4.length) {
          if(n<listAccesorios1.length && verifyList(listAccesorios1[n].code)){
            tempList.add(listAccesorios1[n]);
          }
          if(n<listAccesorios2.length && verifyList(listAccesorios2[n].code)){
            tempList.add(listAccesorios2[n]);
          }
          if(n<listAccesorios3.length && verifyList(listAccesorios3[n].code)){
            tempList.add(listAccesorios3[n]);
          }
          if(n<listAccesorios4.length && verifyList(listAccesorios4[n].code)){
            tempList.add(listAccesorios4[n]);
          }
          n++;
        }

        String newLast = getLastCode(listAccesorios1) + ":";
        newLast += getLastCode(listAccesorios2) + ":";
        newLast += getLastCode(listAccesorios3) + ":";
        newLast += getLastCode(listAccesorios4) + ":";
        state.lastElements = newLast;
      }
      break;
      case "PANADERIA": {
        List<ProductApi> listPanaderia = [];
        if (!state.lastElements.isEmpty){
          listPanaderia = await _productUseCase.getProductsByCateforie('PANADERIA', subCodes[0]);
          listPanaderia.addAll(await _productUseCase.getProductsByCateforie('PANADERIA', listPanaderia.last.code));
        } else {
          listPanaderia = await _productUseCase.getProductsByCateforie('PANADERIA', null);
          listPanaderia.addAll(await _productUseCase.getProductsByCateforie('PANADERIA', listPanaderia.last.code));
        }

        int n = 0;

        while (n<listPanaderia.length) {
          if(n<listPanaderia.length && verifyList(listPanaderia[n].code)){
            tempList.add(listPanaderia[n]);
          }
          n++;
        }
        String newLast = getLastCode(listPanaderia) + ":";
        state.lastElements = newLast;
      }
      break;
    }
    return tempList;
  }

  /**
   * Función para buscar productos que coincidan con el valor de búsqueda
   * solicitado por el usuario. Se agregan estos elementos a la lista del
   * estado.
   */
  void addResults() async {
    List<ProductApi> tempList = [];
    switch(state.currentCategory) {
      case "FRUTASVERDURAS": {
        List<ProductApi> listFrutas1 = await _productUseCase.searchProductsByCategory('FRUTAS NACIONALES', state.searchString);
        List<ProductApi> listFrutas2 = await _productUseCase.searchProductsByCategory('FRUTAS INTERNACIONALES', state.searchString);
        List<ProductApi> listVerduras = await _productUseCase.searchProductsByCategory('VERDURAS', state.searchString);
        List<ProductApi> listTuberculos = await _productUseCase.searchProductsByCategory('TUBERCULOS', state.searchString);
        List<ProductApi> listLegumbres = await _productUseCase.searchProductsByCategory('LEGUMBRES', state.searchString);

        int n = 0;

        while (n<listFrutas1.length || n<listFrutas2.length || n<listVerduras.length || n<listTuberculos.length || n<listLegumbres.length) {
          if(n<listFrutas1.length && verifyList(listFrutas1[n].code)){
            tempList.add(listFrutas1[n]);
          }
          if(n<listFrutas2.length && verifyList(listFrutas2[n].code)){
            tempList.add(listFrutas2[n]);
          }
          if(n<listVerduras.length && verifyList(listVerduras[n].code)){
            tempList.add(listVerduras[n]);
          }
          if(n<listTuberculos.length && verifyList(listTuberculos[n].code)){
            tempList.add(listTuberculos[n]);
          }
          if(n<listLegumbres.length && verifyList(listLegumbres[n].code)){
            tempList.add(listLegumbres[n]);
          }
          n++;
        }
      }
      break;
      case "CARNICERIA": {
        List<ProductApi> listCarneRes = await _productUseCase.searchProductsByCategory('CARNE DE RES', state.searchString);
        List<ProductApi> listCarneCerdo = await _productUseCase.searchProductsByCategory('CARNE DE CERDO', state.searchString);
        List<ProductApi> listCarnePollo = await _productUseCase.searchProductsByCategory('CARNE DE POLLO', state.searchString);
        List<ProductApi> listMariscos = await _productUseCase.searchProductsByCategory('MARISCOS', state.searchString);
        List<ProductApi> listEmbutidos = await _productUseCase.searchProductsByCategory('EMBUTIDOS', state.searchString);

        int n = 0;

        while (n<listCarneRes.length || n<listCarneCerdo.length || n<listCarnePollo.length || n<listMariscos.length || n<listEmbutidos.length) {
          if(n<listCarneRes.length && verifyList(listCarneRes[n].code)){
            tempList.add(listCarneRes[n]);
          }
          if(n<listCarneCerdo.length && verifyList(listCarneCerdo[n].code)){
            tempList.add(listCarneCerdo[n]);
          }
          if(n<listCarnePollo.length && verifyList(listCarnePollo[n].code)){
            tempList.add(listCarnePollo[n]);
          }
          if(n<listMariscos.length && verifyList(listMariscos[n].code)){
            tempList.add(listMariscos[n]);
          }
          if(n<listEmbutidos.length && verifyList(listEmbutidos[n].code)){
            tempList.add(listEmbutidos[n]);
          }
          n++;
        }
      }
      break;
      case "GRANEL": {
        List<ProductApi> listGranel = await _productUseCase.searchProductsByCategory('GRANEL', state.searchString);
        List<ProductApi> listProcesados = await _productUseCase.searchProductsByCategory('PROCESADOS', state.searchString);

        int n = 0;

        while (n<listGranel.length || n<listProcesados.length) {
          if(n<listGranel.length && verifyList(listGranel[n].code)){
            tempList.add(listGranel[n]);
          }
          if(n<listProcesados.length && verifyList(listProcesados[n].code)){
            tempList.add(listProcesados[n]);
          }
          n++;
        }
      }
      break;
      case "ABARROTES": {
        List<ProductApi> listAbarrotes = await _productUseCase.searchProductsByCategory('ABARROTES', state.searchString);
        List<ProductApi> listLacteos = await _productUseCase.searchProductsByCategory('LACTEOS', state.searchString);

        int n = 0;

        while (n<listAbarrotes.length || n<listLacteos.length) {
          if(n<listAbarrotes.length && verifyList(listAbarrotes[n].code)){
            tempList.add(listAbarrotes[n]);
          }
          if(n<listLacteos.length && verifyList(listLacteos[n].code)){
            tempList.add(listLacteos[n]);
          }
          n++;
        }
      }
      break;
      case "LICORES": {
        List<ProductApi> listLicores = await _productUseCase.searchProductsByCategory('LICORES', state.searchString);

        int n = 0;

        while (n<listLicores.length) {
          if (verifyList(listLicores[n].code)) {
            tempList.add(listLicores[n]);
          }
          n++;
        }

      }
      break;
      case "ACCESORIOS": {

        List<ProductApi> listAccesorios1 = await _productUseCase.searchProductsByCategory('PRODUCTO TERMINADO FABRICA DE PLASTICO', state.searchString);
        List<ProductApi> listAccesorios2 = await _productUseCase.searchProductsByCategory('ACCESORIOS Y OTROS', state.searchString);
        List<ProductApi> listAccesorios3 = await _productUseCase.searchProductsByCategory('MATERIA PRIMA FABRICA DE PLASTICO', state.searchString);
        List<ProductApi> listAccesorios4 = await _productUseCase.searchProductsByCategory('MATERIA PRIMA LICITACIONES', state.searchString);

        int n = 0;

        while (n<listAccesorios1.length || n<listAccesorios2.length || n<listAccesorios3.length || n<listAccesorios4.length) {

          if(n<listAccesorios1.length && verifyList(listAccesorios1[n].code)){
            tempList.add(listAccesorios1[n]);
          }
          if(n<listAccesorios2.length && verifyList(listAccesorios2[n].code)){
            tempList.add(listAccesorios2[n]);
          }
          if(n<listAccesorios3.length && verifyList(listAccesorios3[n].code)){
            tempList.add(listAccesorios3[n]);
          }
          if(n<listAccesorios4.length && verifyList(listAccesorios4[n].code)){
            tempList.add(listAccesorios4[n]);
          }
          n++;
        }
      }
      break;
      case "PANADERIA": {
        List<ProductApi> listPanaderia = await _productUseCase.searchProductsByCategory('PANADERIA', state.searchString);

        int n = 0;

        while (n<listPanaderia.length) {
          if (verifyList(listPanaderia[n].code)) {
            tempList.add(listPanaderia[n]);
          }
          n++;
        }

      }
      break;
    }
    emit(state.copyWith(listProducts: tempList));
  }

  /**
   * Función para cargar una nueva lista de productos al cambiar de
   * departamento.
   * @Params : String cateogry
   * Nuevo departamento del cual se deben cargar productos.
   */
  void changeCategory(String category) async{
    emit(state.copyWith(currentCategory: category, lastElements: ""));
    addProducts();
  }

  /**
   * Función encargada de cargar una nueva lista de productos al
   * buscar productos por nombre.
   * @Params : String category
   * Departamento en el cual se va a buscar el producto.
   * @Params: String searchTerm
   * Término que desea buscar el usuario.
   */
  void searchTerm(String category, String searchTerm) async{
    emit(state.copyWith(currentCategory: category, lastElements: "", searchString: searchTerm));
    addResults();
  }

  String getLastCode(List<ProductApi> list){
    String returnValue = '';
    if (list.isNotEmpty){
      returnValue = list.last.code;
    }
    return returnValue;
  }

  /**
   * Función para verificar si un producto a ha sido agregado a la lista
   * para no agregarlo más de una vez.
   * @Params: ProductApi object
   * Objeto del cual queremos
   */
  bool verifyList(String object){
    for (int i = 0; i < state.listProducts.length; i++){
      if (object == state.listProducts[i].code) {
        return false;
      }
    }
    return true;
  }
}
