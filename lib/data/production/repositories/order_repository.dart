import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veggy/domain/models/preorder.dart';

class OrderRepository {
  CollectionReference<Map<String, dynamic>> _ordersRef =
      FirebaseFirestore.instance.collection('ORDERS');

  /*
   * Función encargada de brindar la lista de ordenes de compra
   * almacenados en la base de datos.
   * @Return Future<List<PreOrder>>
   * Lista de ordenes obtenida.
   */
  Future<List<PreOrder>> getOrdenes() async {
    final QuerySnapshot<Map<String, dynamic>> _result;

    _result = await _ordersRef.get();

    return _result.docs.map((e) => PreOrder.fromJson(e.data())).toList();
  }

  /*
   * Funciön encargada de agregar una nueva orden al FireStore
   * base de datos.
   * @Params : PreOrder order
   * Correo electrónico que debe ser agregado a la base de datos.
   * @Return : bool
   * Boleano para indicar si se pudo agregar o no el elemento.
   */
  Future<Map<String, dynamic>> saveOrder(PreOrder order) async {
    try {
      _ordersRef.doc(order.ordenCompra).set(order.toJson());
      return {
        'exito': true,
        "numero_pedido": '',
        "mensajes": '',
      };
    } on FirebaseException catch (e) {
      return {
        'exito': false,
        "numero_pedido": '',
        "mensajes": e.message,
      };
    }
  }
/*
   * Funciön encargada de agregar una nueva orden al FireStore
   * base de datos.
   * @Params : PreOrder order
   * Correo electrónico que debe ser agregado a la base de datos.
   * @Return : bool
   * Boleano para indicar si se pudo agregar o no el elemento.
   */
  Future<Map<String, dynamic>> deleteOrder(PreOrder order) async {
    try {
      _ordersRef.doc(order.ordenCompra).delete();
      return {
        'exito': true,
        "numero_pedido": '',
        "mensajes": '',
      };
    } on FirebaseException catch (e) {
      return {
        'exito': false,
        "numero_pedido": '',
        "mensajes": e.message,
      };
    }
  }
}
