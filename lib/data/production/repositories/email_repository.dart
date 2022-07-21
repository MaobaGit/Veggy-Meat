
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veggy/domain/models/email.dart';

/*
 * Clase para manejo de agregado y cargado de correos de la base
 * de datos.
 */
class EmailRepository {
  late CollectionReference<Map<String, dynamic>> _emailListReference;
  CollectionReference correosElectronicos = FirebaseFirestore.instance.collection('CORREOS ELECTRONICOS');

  /*
   * Función encargada de brindar la lista de correos electrónicos
   * almacenados en la base de datos.
   * @Return Future<List<Email>>
   * Lista de correos electrónicos obtenida.
   */
  Future<List<Email>> getEmails() async{

    _emailListReference = FirebaseFirestore.instance.collection('CORREOS ELECTRONICOS');
    final QuerySnapshot<Map<String, dynamic>> _result;

    _result = await _emailListReference.get();

    return _result.docs.map((e) => Email.fromJson(e.data())).toList();

  }

  /*
   * Funciön encargada de agregar un nuevo correo electrónico
   * a la base de datos.
   * @Params : String receivedEmail
   * Correo electrónico que debe ser agregado a la base de datos.
   * @Return : bool
   * Boleano para indicar si se pudo agregar o no el elemento.
   */
  Future<bool> saveEmail(String receivedEmail) async{

    bool returnValue = false;

    correosElectronicos.add({
      'correo': receivedEmail,
    })
        .then((value) => returnValue = true)
        .catchError((error) => print("Failed to add email: $error"));

    return returnValue;
  }
}