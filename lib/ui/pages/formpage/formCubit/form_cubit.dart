import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veggy/data/production/repositories/order_repository.dart';
import 'package:veggy/data/production/repositories/qupos_server_repository.dart';
import 'package:veggy/data/production/repositories/sms_notifications_repo.dart';
import 'package:veggy/domain/models/cart_product.dart';
import 'package:veggy/domain/models/preorder.dart';
import 'package:veggy/util/regularExpressions/regular_expressions_models.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormCubitState> {
  FormCubit() : super(FormCubitState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate(
          [email, state.userNameComplete, state.addres, state.phone, state.id]),
    ));
  }

  void userNameChanged(String value) {
    final userName = UserName.dirty(value);
    emit(state.copyWith(
      userNameComplete: userName,
      status: Formz.validate(
          [userName, state.addres, state.email, state.phone, state.id]),
    ));
  }

  void phoneChanged(String value) {
    final phone = NumberPhone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate(
          [phone, state.addres, state.userNameComplete, state.email, state.id]),
    ));
  }

  void addresChanged(String value) {
    final addres = AddrresForm.dirty(value);
    emit(state.copyWith(
      addres: addres,
      status: Formz.validate([
        state.phone,
        addres,
        state.email,
        state.id,
        state.userNameComplete,
      ]),
    ));
  }

  void idChanged(String value) {
    final id = NumberNoEmpty.dirty(value);
    emit(state.copyWith(
      id: id,
      status: Formz.validate(
          [state.phone, state.addres, state.email, id, state.userNameComplete]),
    ));
  }

  void sendPreOrder(List<CartProduct> listProduct) async {
    if (state.status == FormzStatus.invalid) return;
    emit(state.copyWith(statusSummit: StatudSummit.pure));
    // final repoQupos = QuposRepository(); //peticon http al servidot local de qupos en el supermercado
    final _orderRepo = OrderRepository();
    final repoNotidications = SmsNotificationRepository();
    String detalle = '';
    final preOrder = PreOrder(
      bodega: "001",
      cargoEnvio: 0,
      cedula: state.id.value,
      detalles: [],
      email: state.email.value,
      nombreCliente: state.userNameComplete.value,
      codigoCliente: '',
      fechaHora: DateTime.now().toString(),
      notas: 'Numero de telefono: +506 ${state.phone.value}',
      ordenCompra: state.id.value + '-' + DateTime.now().toString(),
      tipoCedula: 'F',
    );
    listProduct.forEach((product) {
      preOrder.detalles.add(product.product);
      detalle = detalle +
          'Producto: ' +
          product.name +
          ' ' +
          'Código: ' +
          product.product.codigoArticulo +
          '\n';
    });
    // final responce = await repoQupos.postPreventa(preOrder);//Enviar directamente Qupos,17/07/2021 tiene un error de XMLErrorRequest
    final responce = await _orderRepo.saveOrder(
        preOrder); //Enviar a fireBase y que desde la app admin aprueben y envien a qupos
    if (responce['exito']) {
      final message =
          'Buenos días.\nHe realizado una compra en la página de Veggy.\nOrdenCompra: ${preOrder.ordenCompra}\nNumeroPedido: ${responce['numero_pedido']} \nNombre: ${state.userNameComplete.value}\nCédula: ${state.id.value}\nTeléfono: ${state.phone.value}\nFecha: ${DateTime.now().toString()}\n Detalle: $detalle\nPor favor confirmar si recibieron el pedido.';
      repoNotidications.sendWhatsappNotification(message, '89395313');
      // await canLaunch(_url(message))
      //     ? await launch(_url(message))
      //     : print('Could not launch $_url');
      emit(state.copyWith(statusSummit: StatudSummit.summited, message: ''));
    } else {
      emit(state.copyWith(
          statusSummit: StatudSummit.error, message: responce['mensajes']));
    }
  }

  // String _url(String message) {
  //   return "https://api.whatsapp.com/send?phone=${'+506 ' + '89395313'}&text=$message"; // new line
  // }
}
