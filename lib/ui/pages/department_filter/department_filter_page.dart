import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggy/ui/pages/department_filter/cubit/departmentFilter_cubit.dart';
import 'package:veggy/ui/widgets/bottomBar.dart';
import 'package:veggy/ui/widgets/grid_product_view.dart';
import 'package:veggy/domain/usecases/products_usecase.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/util/sizingInfo.dart';

/*
 * Clase encargada de manejar la vista de productos por departamento,
 * ofreciendo un filtro para el contenido mostrado.
 * @Params : currentDepartment, Departamento actualmente seleccionado por
 * el usuario. Si no se brinda departamento, se utilizará el departamento
 * Frutas y Verduras.
 */
class DepartmentFilterPage extends StatelessWidget {
  DepartmentFilterPage({required this.currentDepartment}) : super();
  final String currentDepartment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DepartmentFilterCubit()..changeCategory(currentDepartment),
      child: MyMainContainer(
        currentDepartment: currentDepartment,
      ),
    );
  }
}

/*
 * Objeto de manejo de selección de categorías.
 */
enum DrawerSelection {
  frutasverduras,
  carniceria,
  granel,
  abarrotes,
  licores,
  accesorios,
  panaderia
}

/*
 * Clase encargada de popular visualmente la sección de vista
 * por departamentos.
 * @Params : String currentDepartment
 * Departamento del cual se cargarán los productos de la vista.
 * @Return : BlocBuilder
 * Objeto de construcción de la vista con el contenido cargado.
 */
class MyMainContainer extends StatelessWidget {
  MyMainContainer({required this.currentDepartment}) : super();
  DrawerSelection _drawerSelection = DrawerSelection.frutasverduras;
  final String currentDepartment;
  final ProductUseCase useCase = ProductUseCase();
  ScrollController myController = new ScrollController();
  var searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /**
     * Switch para manejo del departamento seleccionado, marcando el
     * departamento correcto en el filtro y estableciendo el departamento
     * del cual obtener los productos.
     */
    switch (currentDepartment) {
      case "FRUTASVERDURAS":
        {
          _drawerSelection = DrawerSelection.frutasverduras;
        }
        break;

      case "CARNICERIA":
        {
          _drawerSelection = DrawerSelection.carniceria;
        }
        break;

      case "GRANEL":
        {
          _drawerSelection = DrawerSelection.granel;
        }
        break;

      case "ABARROTES":
        {
          _drawerSelection = DrawerSelection.abarrotes;
        }
        break;

      case "LICORES":
        {
          _drawerSelection = DrawerSelection.licores;
        }
        break;

      case "ACCESORIOS":
        {
          _drawerSelection = DrawerSelection.accesorios;
        }
        break;

      case "PANADERIA":
        {
          _drawerSelection = DrawerSelection.panaderia;
        }
        break;

      default:
        {
          _drawerSelection = DrawerSelection.frutasverduras;
        }
        break;
    }

    return BlocBuilder<DepartmentFilterCubit, DepartmentFilterState>(
        builder: (context, state) {
      myController.addListener((){
        if (myController.position.pixels == myController.position.maxScrollExtent && searchFieldController.text == "") {
          context.read<DepartmentFilterCubit>().addProducts();
        }
      });
      return Scrollbar(
        controller: myController,
        child: Column(
          children: [
            Expanded(
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /**
                   * Contenedor de filtros de la vista.
                   */
                  Container(
                    width: 220.0,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                          child: Container(
                            child: TextField(
                              controller: searchFieldController,
                              // onChanged: (value) {
                              //   final a = ProductRepository();
                              //   a.searchProductsByCategory(
                              //       state.currentCategory, value);
                              // },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Buscar',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<DepartmentFilterCubit>()
                                        .searchTerm(state.currentCategory,
                                        searchFieldController.text);
                                  },
                                  icon: Icon(Icons.search),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Center(
                            child: Text('Departamentos'),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              SizedBox(height: 10),
                              ListTile(
                                selected: _drawerSelection ==
                                    DrawerSelection.frutasverduras,
                                onTap: () {
                                  if (_drawerSelection !=
                                      DrawerSelection.frutasverduras) {
                                    _drawerSelection =
                                        DrawerSelection.frutasverduras;
                                    context
                                        .read<DepartmentFilterCubit>()
                                        .changeCategory("FRUTASVERDURAS");
                                    NavigationService.navigateToWithArguments(
                                        'departmentFilter/${"FRUTASVERDURAS"}',
                                        null);
                                  }
                                },
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 36,
                                    maxHeight: 36,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/icono_frutas_y_verduras.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text('Frutas y Verduras'),
                              ),
                              ListTile(
                                selected: _drawerSelection ==
                                    DrawerSelection.carniceria,
                                onTap: () {
                                  if (_drawerSelection !=
                                      DrawerSelection.carniceria) {
                                    _drawerSelection =
                                        DrawerSelection.carniceria;
                                    context
                                        .read<DepartmentFilterCubit>()
                                        .changeCategory("CARNICERIA");
                                    NavigationService.navigateToWithArguments(
                                        'departmentFilter/${"CARNICERIA"}',
                                        null);
                                  }
                                },
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 36,
                                    maxHeight: 36,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/icono_carniceria.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text('Carnicería'),
                              ),
                              ListTile(
                                selected:
                                _drawerSelection == DrawerSelection.granel,
                                onTap: () {
                                  if (_drawerSelection !=
                                      DrawerSelection.granel) {
                                    _drawerSelection = DrawerSelection.granel;
                                    context
                                        .read<DepartmentFilterCubit>()
                                        .changeCategory("GRANEL");
                                    NavigationService.navigateToWithArguments(
                                        'departmentFilter/${"GRANEL"}', null);
                                  }
                                },
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 36,
                                    maxHeight: 36,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/icono_granel.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text('Granel'),
                              ),
                              ListTile(
                                selected: _drawerSelection ==
                                    DrawerSelection.abarrotes,
                                onTap: () {
                                  if (_drawerSelection !=
                                      DrawerSelection.abarrotes) {
                                    _drawerSelection =
                                        DrawerSelection.abarrotes;
                                    context
                                        .read<DepartmentFilterCubit>()
                                        .changeCategory("ABARROTES");
                                    NavigationService.navigateToWithArguments(
                                        'departmentFilter/${"ABARROTES"}',
                                        null);
                                  }
                                },
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 36,
                                    maxHeight: 36,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/icono_abarrotes.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text('Abarrotes'),
                              ),
                              ListTile(
                                selected:
                                _drawerSelection == DrawerSelection.licores,
                                onTap: () {
                                  if (_drawerSelection !=
                                      DrawerSelection.licores) {
                                    _drawerSelection = DrawerSelection.licores;
                                    context
                                        .read<DepartmentFilterCubit>()
                                        .changeCategory("LICORES");
                                    NavigationService.navigateToWithArguments(
                                        'departmentFilter/${"LICORES"}', null);
                                  }
                                },
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 36,
                                    maxHeight: 36,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/icono_licores.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text('Licores'),
                              ),
                              ListTile(
                                selected: _drawerSelection ==
                                    DrawerSelection.accesorios,
                                onTap: () {
                                  if (_drawerSelection !=
                                      DrawerSelection.accesorios) {
                                    _drawerSelection =
                                        DrawerSelection.accesorios;
                                    context
                                        .read<DepartmentFilterCubit>()
                                        .changeCategory("ACCESORIOS");
                                    NavigationService.navigateToWithArguments(
                                        'departmentFilter/${"ACCESORIOS"}',
                                        null);
                                  }
                                },
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 36,
                                    maxHeight: 36,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/icono_accesorios.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text('Accesorios'),
                              ),
                              ListTile(
                                selected: _drawerSelection ==
                                    DrawerSelection.panaderia,
                                onTap: () {
                                  if (_drawerSelection !=
                                      DrawerSelection.panaderia) {
                                    _drawerSelection =
                                        DrawerSelection.panaderia;
                                    context
                                        .read<DepartmentFilterCubit>()
                                        .changeCategory("PANADERIA");
                                    NavigationService.navigateToWithArguments(
                                        'departmentFilter/${"PANADERIA"}',
                                        null);
                                  }
                                },
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 36,
                                    maxHeight: 36,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/icono_panaderia.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text('Panadería'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /**
                   * Contenedor de la lista de productos.
                   */
                  Expanded(
                    child: Container(
                      color: Colors.black,
                      child: GridProductWidget(
                          listProduct: state.listProducts,
                          controller: myController),
                    ),
                  ),
                ],
              ),
            ),
            /**
             * Footer de la página.
             */
            isDesktop(context)? BottomBar(): Container(),
          ],
        ),
      );
    });
  }
}