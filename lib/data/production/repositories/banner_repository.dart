import 'package:firebase_storage/firebase_storage.dart';
import 'package:veggy/domain/models/carouselModel.dart';

class BannerRepository {
  Reference storageRef = FirebaseStorage.instance.ref().child('Banners');
  Reference storageRefFeatured = FirebaseStorage.instance.ref().child('Destacados');
  List<CarouselModel> carouselList = [];
  List<String> featuredList = [];
  /*Este método trae de el almacenamiento de firebase todas las imagenes
    que se encuentren en la carpeta Banners para mostrarlas en el carrousel
    Return: Future<List<CarouselModel>>*/
  Future<List<CarouselModel>> allBannersImages() async {
    ListResult resultRefs =
        await storageRef.listAll(); // Obtiene todos los archivos del storage
    final urls = await _getDownloadUrls(resultRefs.items);
    return carouselList = urls.asMap().map((index, url) {
          return MapEntry(index,
              new CarouselModel(index: index, image: url, isSelected: false));
        })
        .values
        .toList();
  }

  /*Este método recibe una lista de referencias de firebase para obtener el url
   de cada imagen a la que hacer referencia
   @Params : List<Reference> resultRefs, lista de referencias de firebase
   @Return : Future<List<String>>, lista de las urls de cada imagen*/
  Future<List<String>> _getDownloadUrls(List<Reference> resultRefs) async {
    return Future.wait(resultRefs.map((ref) => ref.getDownloadURL()).toList());
  }

  /*Este método trae de el almacenamiento de firebase todas las imagenes
    que se encuentren en la carpeta Destacados para mostrarlas en la seccion de destacados
    Return: Future<List<String>>*/
  Future<List<String>> allFeaturedImages() async {
    ListResult resultRefs =
        await storageRefFeatured.listAll(); // Obtiene todos los archivos del storage
    final urls = await _getDownloadUrls(resultRefs.items);
    return featuredList = urls.asMap().map((index, url) {
          return MapEntry(index, url);
        })
        .values
        .toList();
  }
}
