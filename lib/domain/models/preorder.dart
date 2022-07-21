import 'package:veggy/domain/models/product.dart';

class PreOrder {
  late String codigoCliente;
  late String ordenCompra;
  late String fechaHora;
  late String notas;
  late String cedula;
  late String tipoCedula;
  late String email;
  late String nombreCliente;
  late int cargoEnvio;
  late String bodega;
  late List<Product> detalles;

  PreOrder(
      {required this.codigoCliente,
      required this.ordenCompra,
      required this.fechaHora,
      required this.notas,
      required this.cedula,
      required this.tipoCedula,
      required this.email,
      required this.nombreCliente,
      required this.cargoEnvio,
      required this.bodega,
      required this.detalles});

  PreOrder.fromJson(Map<String, dynamic> json) {
    this.codigoCliente = json['codigo_cliente'];
    this.ordenCompra = json['orden_compra'];
    this.fechaHora = json['fecha_hora'];
    this.notas = json['notas'];
    this.cedula = json['cedula'];
    this.tipoCedula = json['tipo_cedula'];
    this.email = json['email'];
    this.nombreCliente = json['nombre_cliente'];
    this.cargoEnvio = json['cargo_envio'];
    this.bodega = json['bodega'];
    this.detalles =
        json['detalles'].map((prodcut) => Product.fromJson(prodcut));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_cliente'] = this.codigoCliente.toString();
    data['orden_compra'] = this.ordenCompra.toString();
    data['fecha_hora'] = this.fechaHora.toString();
    data['notas'] = this.notas.toString();
    data['cedula'] = this.cedula.toString();
    data['tipo_cedula'] = this.tipoCedula.toString();
    data['email'] = this.email;
    data['nombre_cliente'] = this.nombreCliente.toString();
    data['cargo_envio'] = this.cargoEnvio;
    data['bodega'] = this.bodega;
    data['detalles'] = this.detalles.map((v) => v.toJson()).toList();
    return data;
  }

  
}
