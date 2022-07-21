import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veggy/domain/models/product_api.dart';

class ProductRepository {
  late CollectionReference<Map<String, dynamic>> _productsCategoryRef;
  /*
    category = nombre de la categoria
    startDocumentId = el utimo ID de producto que se tenga en la lista, 
    si se envia null devuelve los primeros 10 productos de la categoria

  Este método recibe el nombre de la categoria y el id del ultimo documento de la lista,
   @Params : category,startDocumentId
   @Return : Future<List<ProductApi>>, lista de los productos
   */
  Future<List<ProductApi>> getProductsByCategory(
      String category, String? startDocumentId) async {
    _productsCategoryRef =
        FirebaseFirestore.instance.collection(category.toUpperCase());

    final QuerySnapshot<Map<String, dynamic>> _resul;

    if (startDocumentId != null) {
      final DocumentSnapshot _startDocument =
          await _productsCategoryRef.doc(startDocumentId).get();
      _resul = await _productsCategoryRef
          .startAfterDocument(_startDocument)
          .where('active', isEqualTo: 1)
          .limit(10)
          .get();
    } else {
      _resul = await _productsCategoryRef
          .where('active', isEqualTo: 1)
          .limit(10)
          .get();
    }

    return _resul.docs.map((e) => ProductApi.fromJson(e.data())).toList();
  }

  Future<ProductApi> getOneProductsByCategory(
      String category, String documentId) async {
    _productsCategoryRef =
        FirebaseFirestore.instance.collection(category.toUpperCase());

    final DocumentSnapshot<Map<String, dynamic>> _startDocument =
        await _productsCategoryRef.doc(documentId).get();

    return ProductApi.fromJson(_startDocument.data()!);
  }

  /*
   Este método busca en la base de datos los productos que tengan concidencia
   con el searchQuery
   @Params : category,searchQuery
   @Return : Future<List<ProductApi>>, lista de los productos
   */
  Future<List<ProductApi>> searchProductsByCategory(
      String category, String searchQuery) async {
    _productsCategoryRef =
        FirebaseFirestore.instance.collection(category.toUpperCase());
    final upperName = searchQuery.toUpperCase();
    final _resul = await _productsCategoryRef
        .where(
          'name',
          isGreaterThanOrEqualTo: upperName.toUpperCase(),
          isLessThan: upperName.substring(0, upperName.length - 1) +
              String.fromCharCode(
                  upperName.codeUnitAt(upperName.length - 1) + 1),
        )
        .get();

    return _resul.docs.map((e) => ProductApi.fromJson(e.data())).toList();
  }
}
