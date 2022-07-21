import 'package:veggy/data/local/local_db.dart';
import 'package:veggy/domain/models/product_detail.dart';


class ProductSateLocalUseCase {
  final _productsLocalRepo = LocalBD();

  void saveProductStateLocalDB(ProductDetail productDetail) {
    _productsLocalRepo.saveProductDetailState(productDetail);
  }

  Future<ProductDetail?> getProductStateLocalDB() async {
    final product = await _productsLocalRepo.getProductDetailState();
    return product;
  }
}
