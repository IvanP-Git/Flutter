// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/search_controller.dart';

class Main extends StatelessWidget { // Clase principal que maneja la navegación inferior
  Main({super.key});
  final BottomNavigatorController controller = Get.put(BottomNavigatorController()); // Controlador de navegación inferior
  final SearchController1 searchController = Get.put(SearchController1()); // Controlador de búsqueda
  final MoviesController moviesController = Get.put(MoviesController()); // Controlador de películas
  
  @override
  Widget build(BuildContext context) { // Construcción del widget
    return Obx( // Observador para actualizar la UI cuando cambie el índice
      () => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold( // Estructura principal de la pantalla
          body: SafeArea(
            child: IndexedStack(
              index: controller.index.value,
              children: Get.find<BottomNavigatorController>().screens, // Pantallas correspondientes a cada pestaña
            ),
          ),
          bottomNavigationBar: Container( // Barra de navegación inferior
            height: 78,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF0296E5),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar( // Elemento de navegación inferior
              currentIndex: controller.index.value,
              onTap: (index) =>
                  Get.find<BottomNavigatorController>().setIndex(index), // Actualizar el índice al tocar una pestaña
              backgroundColor: const Color(0xFF242A32),
              selectedItemColor: const Color(0xFF0296E5),
              unselectedItemColor: const Color(0xFF67686D),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                BottomNavigationBarItem( // Elemento de la pestaña "Home"
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Home.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 0
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem( // Elemento de la pestaña "Search"
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Search.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 1
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Search',
                  tooltip: 'Search Movies',
                ),
                BottomNavigationBarItem( // Elemento de la pestaña "Watch list"
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Save.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 2
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Watch list',
                  tooltip: 'Your WatchList',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
