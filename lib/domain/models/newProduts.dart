import 'package:veggy/domain/models/product_api.dart';

class NewProducts{
  late List<ProductApi> listNewProducts;

  NewProducts({required this.listNewProducts});

  NewProducts.fromJson(Map<String, dynamic> json) {
    this.listNewProducts =
        json['listNewProducts'].map<ProductApi>((prodcut) => ProductApi.fromJson(prodcut)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listNewProducts'] =
        this.listNewProducts.map((newProduct) => newProduct.toJson()).toList();
    return data;
  }

}