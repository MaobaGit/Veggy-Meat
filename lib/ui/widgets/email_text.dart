import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veggy/data/production/repositories/email_repository.dart';
import 'package:veggy/util/regularExpressions/email.dart';

/**
 * Clase tipo widget que maneja el widget para contener el campo de texto con
 * opción de envío para el almacenamiento de correos electrónicos
 * de usuarios que deseen ser notificados de noticias.
 * @Return : Container
 * Contenedor con los elementos visuales del widget.
 */
class EmailText extends StatelessWidget {

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecoration(),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: ' Correo electrónico',
          suffix: TextButton(
            onPressed: () => _addEmail(_controller.text, context),
            child: Text('Enviar'),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
  );

  /**
   * Función que se encarga de solicitar el agregado de un nuevo
   * correo a un nuevo repositorio de correos.
   * @Params : String text
   * Dirección de correo en forma de cadena de caracteres a agregar.
   * @Params : Context context
   * Conexto del contenedor padre que llama a la función.
   */
  _addEmail(text, context) {
    //Aqui se debe manejar el correo que el usuario ingresó.
    var repReference = EmailRepository();
    if (RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$').hasMatch(text)){
      repReference.saveEmail(text);
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Text('Gracias por brindarnos tu correo'),
              content: Text('Te haremos llegar información de promociones por este medio.'),
            );
          }
      );
      _controller.text = "";
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Text('Correo incorrecto'),
              content: Text('La dirección de correo debe ser válida.'),
            );
          }
      );
    }

  }
}