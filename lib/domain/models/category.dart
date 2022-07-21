
class Category {
  final String? image;
  final bool? isSelected;
  final String? name; 
  Category({this.image, this.isSelected, this.name});
}

 List<Category> categories = [
    Category(
      name: 'ACCESORIOS',
      image: 'assets/icons/Boton_naranja_inactivo_Accesorios.svg'
    ),
    Category(
      name: 'CARNICERIA',
      image: 'assets/icons/Boton_naranja_inactivo_carniceria.svg'
    ),
    Category(
      name: 'FRUTASVERDURAS',
      image: 'assets/icons/Boton_naranja_inactivo_Frutas_y_verduras.svg'
    ),
    Category(
      name: 'GRANEL',
      image: 'assets/icons/Boton_naranja_inactivo_Granel.svg'
    ),
    Category(
      name: 'LICORES',
      image: 'assets/icons/Boton_naranja_inactivo_Licores_y_cerveza.svg'
    ),
    Category(
      name: 'FRUTASVERDURAS',
      image: 'assets/icons/Boton_naranja_inactivo_panaderia.svg'
    ),
    Category(
      name: 'ABARROTES',
      image: 'assets/icons/Boton_naranja_inactivo_Abarrotes.svg'
    )
  ];

