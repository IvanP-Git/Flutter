// Importaciones necesarias
import 'package:get/get.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:movies/screens/search_screen.dart';
import 'package:movies/screens/watch_list_screen.dart';

class BottomNavigatorController extends GetxController { // Controlador para la navegación inferior
  var screens = [ // Lista de pantallas
    HomeScreen(), // Pantalla de inicio
    const SearchScreen(), // Pantalla de búsqueda
    const WatchList(), // Pantalla de lista de seguimiento
  ];
  var index = 0.obs;
  void setIndex(indx) => index.value = indx; // Método para actualizar el índice
}