// Importaciones necesarias
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

class ActorsController extends GetxController { // Controlador para manejar actores
  var isLoading = false.obs; // Indicador de carga
  var popularActors = <Actor>[].obs; // Lista de actores populares
  var otherPopularActors = <Actor>[].obs; // Lista adicional de actores populares
  var watchListActors = <Actor>[].obs; // Lista de actores en la lista de seguimiento

  @override
  void onInit() async { // Método llamado al inicializar el controlador
    isLoading.value = true; // Indicar que se está cargando
    popularActors.value = (await ApiService.getPopularActors())!; // Obtener actores populares
    otherPopularActors.value = (await ApiService.getMorePopularActors())!; // Obtener más actores populares
    isLoading.value = false; // Indicar que la carga ha finalizado
    super.onInit();
  }

  bool isInWatchList(Actor actor) {
    return watchListActors.any((a) => a.id == actor.id);
  } // Verificar si un actor está en la lista de seguimiento

  void addToWatchList(Actor actor) { // Método para agregar o eliminar un actor de la lista de seguimiento
    if (watchListActors.any((a) => a.id == actor.id)) { // Verificar si el actor ya está en la lista
      watchListActors.remove(actor); // Eliminar actor de la lista
      Get.snackbar('Success', 'Removed from watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      watchListActors.add(actor); // Agregar actor a la lista
      Get.snackbar('Success', 'Added to watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}