// Importaciones necesarias
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/controllers/actors_controller.dart';

class MoviesController extends GetxController { // Controlador para manejar películas y lista de seguimiento
  var isLoading = false.obs; // Indicador de carga
  var mainTopRatedMovies = <Movie>[].obs; // Lista de películas mejor valoradas
  var watchListMovies = <Movie>[].obs; // Lista de películas en la lista de seguimiento
  var watchListActors = <Actor>[].obs; // Lista de actores en la lista de seguimiento

  @override
  void onInit() async {
    isLoading.value = true; // Inicia la carga
    mainTopRatedMovies.value = (await ApiService.getTopRatedMovies())!; // Obtiene las películas mejor valoradas desde el servicio API
    isLoading.value = false; // Finaliza la carga
    super.onInit();
  }

  bool isInWatchList(Movie movie) {
    return watchListMovies.any((m) => m.id == movie.id);
  } // Verifica si una película está en la lista de seguimiento

  void addToWatchList(Movie movie) {
    final wasInList = watchListMovies.any((m) => m.id == movie.id); // Verifica si la película ya está en la lista
    watchListMovies.removeWhere((m) => m.id == movie.id); // Elimina la película si ya está en la lista

    if (wasInList) { // Si la película estaba en la lista, se elimina
      Get.snackbar('Success', 'removed from watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      watchListMovies.add(movie); // Agrega la película a la lista de seguimiento
      watchListActors.removeWhere((a) => a.id == movie.id); // Elimina actores relacionados si es necesario
      try {
        final actorsCtrl = Get.find<ActorsController>(); // Sincroniza con ActorsController si está presente
        actorsCtrl.watchListActors.removeWhere((a) => a.id == movie.id); // Elimina actores relacionados
      } catch (_) {} // Ignora errores si ActorsController no está presente
      Get.snackbar('Success', 'added to watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }

  bool isActorInWatchList(Actor actor) {
    return watchListActors.any((a) => a.id == actor.id);
  } // Verifica si un actor está en la lista de seguimiento

  void addToWatchListActor(Actor actor) {
    if (watchListActors.any((a) => a.id == actor.id)) { // Verifica si el actor ya está en la lista
      watchListActors.removeWhere((a) => a.id == actor.id); // Elimina el actor si ya está en la lista
      try {
        final actorsCtrl = Get.find<ActorsController>(); // Sincroniza con ActorsController si está presente
        actorsCtrl.watchListActors.removeWhere((a) => a.id == actor.id); // Elimina el actor
      } catch (_) {} // Ignora errores si ActorsController no está presente
      Get.snackbar('Success', 'removed actor from watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      watchListActors.add(actor); // Agrega el actor a la lista de seguimiento
      try {
        final actorsCtrl = Get.find<ActorsController>(); // Sincroniza con ActorsController si está presente
        actorsCtrl.watchListActors.add(actor); // Agrega el actor
      } catch (_) {} // Ignora errores si ActorsController no está presente
      Get.snackbar('Success', 'added actor to watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}
