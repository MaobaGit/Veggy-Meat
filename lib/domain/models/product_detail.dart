import 'package:veggy/domain/models/product_api.dart';

class ProductDetail {
  late ProductApi product;
  late List<ProductApi> sameListProduct;

  ProductDetail({required this.product, required this.sameListProduct});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    this.product = ProductApi.fromJson(json['product']);
    this.sameListProduct =
        json['sameListProduct'].map<ProductApi>((prodcut) => ProductApi.fromJson(prodcut)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['sameListProduct'] =
        this.sameListProduct.map((v) => v.toJson()).toList();
    return data;
  }
}
