// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/widgets/top_rated_actor_item.dart';
import 'package:movies/widgets/actor_item.dart';
import 'package:movies/widgets/search_box.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';


class HomeScreen extends StatelessWidget { // Pantalla principal de la aplicación
  HomeScreen({super.key});

  final ActorsController actorController = Get.put(ActorsController()); // Controlador para manejar datos de actores

  @override
  Widget build(BuildContext context) { // Construcción de la interfaz de usuario
    return SingleChildScrollView( 
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 42,
        ),
        child: Column( // Columna principal que contiene todos los elementos de la pantalla
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text( // Título principal
                'What do you want to watch?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SearchBox( // Caja de búsqueda para buscar actores
              onSumbit: () { // Acción al enviar la búsqueda
                String search = Get.find<SearchController1>().searchController.text; // Obtener el texto de búsqueda
                Get.find<SearchController1>().searchController.text = ''; // Limpiar el campo de búsqueda
                final ctrl = Get.find<SearchController1>(); // Obtener el controlador de búsqueda
                ctrl.isActorSearch.value = true; // Indicar que es una búsqueda de actores
                ctrl.searchActors(search); // Realizar la búsqueda de actores
                Get.find<BottomNavigatorController>().setIndex(1); // Cambiar a la pestaña de resultados de búsqueda
                FocusManager.instance.primaryFocus?.unfocus(); // Ocultar el teclado
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Obx( // Observador para actualizar la UI cuando cambian los datos
              (() => actorController.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox( // Lista horizontal de actores mejor valorados
                      height: 300,
                      child: ListView.separated(
                        itemCount: actorController.popularActors.length, // Número de actores mejor valorados
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 24),
                        itemBuilder: (_, index) => TopRatedActorItem(
                            actor: actorController.popularActors[index],
                            index: index + 1
                          ),
                      ),
                    )),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text( // Subtítulo para otros actores populares
                'Other Popular People',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx( // Observador para actualizar la UI cuando cambian los datos
              (() => actorController.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 300,
                      child: ListView.separated( // Lista horizontal de otros actores populares
                        itemCount: actorController.otherPopularActors.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 24),
                        itemBuilder: (_, index) => ActorItem(
                            actor: actorController.otherPopularActors[index]),
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
