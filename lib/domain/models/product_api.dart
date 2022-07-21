class ProductApi {
  late int cImpProductId;
  late int id;
  late String code;
  late String name;
  late String upcCode;
  late String itemGroupId;
  late String itemGroup;
  late double listPrice;
  late double minPrice;
  late double miscAmount;
  late double costPrice;
  late double mSRP;
  late double packSize;
  late double unitWeight;
  late double grossWeight;
  late int inStock;
  late int unitType;
  late double misc1;
  late String misc2;
  late String misc3;
  late String misc4;
  late String misc5;
  late String misc6;
  late String misc7;
  late String misc8;
  late int active;
  late int ecommerceActive;
  late String unidad;
  late String imageUrl;

  ProductApi(
      {this.cImpProductId = 0,
      this.id = 0,
      this.code = '',
      this.name = '',
      this.upcCode = '',
      this.itemGroupId = '',
      this.itemGroup = '',
      this.listPrice = 0.0,
      this.minPrice = 0.0,
      this.miscAmount = 0.0,
      this.costPrice = 0.0,
      this.mSRP = 0.0,
      this.packSize = 0.0,
      this.unitWeight = 0.0,
      this.grossWeight = 0.0,
      this.inStock = 0,
      this.unitType = 0,
      this.misc1 = 0.0,
      this.misc2 = '',
      this.misc3 = '',
      this.misc4 = '',
      this.misc5 = '',
      this.misc6 = '',
      this.misc7 = '',
      this.misc8 = '',
      this.active = 1,
      this.unidad = '',
      this.imageUrl = '',
      this.ecommerceActive = 0});

  ProductApi.fromJson(Map<String, dynamic> json) {
    cImpProductId = json['cImpProductId'] ?? 0;
    id = json['Id'] ?? 0;
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    upcCode = json['upcCode'] ?? '';
    itemGroupId = json['ItemGroupId'] ?? '';
    itemGroup = json['ItemGroup'] ?? '';
    listPrice = json['listPrice'] != null ? json['listPrice'].toDouble() : 0.0;
    minPrice = json['minPrice'] != null ? json['minPrice'].toDouble() : 0.0;
    miscAmount =
        json['miscAmount'] != null ? json['miscAmount'].toDouble() : 0.0;
    costPrice = json['costPrice'] != null ? json['costPrice'].toDouble() : 0.0;
    mSRP = json['MSRP'] != null ? json['MSRP'].toDouble() : 0.0;
    packSize = json['packSize'] != null ? json['packSize'].toDouble() : 0.0;
    unitWeight =
        json['unitWeight'] != null ? json['unitWeight'].toDouble() : 0.0;
    grossWeight =
        json['grossWeight'] != null ? json['grossWeight'].toDouble() : 0.0;
    inStock = json['InStock'] != null ? json['InStock'].toInt() : 0;
    unitType = json['UnitType'] != null ? json['UnitType'] : 0;
    misc1 = json['misc1'] != null ? json['misc1'].toDouble() : 0.0;
    misc2 = json['misc2'] ?? '';
    misc3 = json['misc3'] ?? '';
    misc4 = json['misc4'] ?? '';
    misc5 = json['misc5'] ?? '';
    misc6 = json['misc6'] ?? '';
    misc7 = json['misc7'] ?? '';
    misc8 = json['misc8'] ?? '';
    active = json['active'] ?? 1;
    unidad = json['unidad'] ?? '';
    imageUrl = json['imageUrl'] ?? '';
    ecommerceActive = json['ecommerceActive'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cImpProductId'] = this.cImpProductId;
    data['Id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['upcCode'] = this.upcCode;
    data['ItemGroupId'] = this.itemGroupId;
    data['ItemGroup'] = this.itemGroup;
    data['listPrice'] = this.listPrice;
    data['minPrice'] = this.minPrice;
    data['miscAmount'] = this.miscAmount;
    data['costPrice'] = this.costPrice;
    data['MSRP'] = this.mSRP;
    data['packSize'] = this.packSize;
    data['unitWeight'] = this.unitWeight;
    data['grossWeight'] = this.grossWeight;
    data['InStock'] = this.inStock;
    data['UnitType'] = this.unitType;
    data['misc1'] = this.misc1;
    data['misc2'] = this.misc2;
    data['misc3'] = this.misc3;
    data['misc4'] = this.misc4;
    data['misc5'] = this.misc5;
    data['misc6'] = this.misc6;
    data['misc7'] = this.misc7;
    data['misc8'] = this.misc8;
    data['active'] = this.active;
    data['ecommerceActive'] = this.ecommerceActive;
    data['unidad'] = this.unidad;
    data['imageUrl'] = this.imageUrl;

    return data;
  }
}
