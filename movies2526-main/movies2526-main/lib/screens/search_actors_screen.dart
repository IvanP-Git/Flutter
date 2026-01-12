// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/actor_details_screen.dart';
import 'package:movies/widgets/top_rated_actor_item.dart';
import 'package:movies/widgets/search_box.dart';

class SearchActorScreen extends StatefulWidget { // Pantalla para buscar actores
  const SearchActorScreen({super.key});

  @override
  State<SearchActorScreen> createState() => _SearchActorScreenState(); // Crear estado asociado
}

class _SearchActorScreenState extends State<SearchActorScreen> {
  final SearchController1 controller = Get.find<SearchController1>(); // Obtener controlador de búsqueda

  @override
  Widget build(BuildContext context) { // Construir la interfaz de usuario
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
        child: Column(
          children: [
            Row( // Fila con botón de retroceso, título e ícono de información
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton( // Botón para volver a la pantalla principal
                  tooltip: 'Back to home',
                  onPressed: () =>
                      Get.find<BottomNavigatorController>().setIndex(0),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const Text( // Título de la pantalla
                  'Search Actors',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
                const Tooltip( // Ícono de información con descripción
                  message: 'Search actors by name',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SearchBox( // Caja de búsqueda para ingresar el nombre del actor
              onSumbit: () { // Acción al enviar la búsqueda
                String search = controller.searchController.text;
                controller.searchController.text = '';
                controller.search(search);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(height: 34),
            Obx( // Observar cambios en el estado del controlador
              () {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator(); // Mostrar indicador de carga mientras se buscan actores
                } else if (controller.foundedActors.isEmpty) {
                  return SizedBox(
                    width: Get.width / 1.5,
                    child: Column(
                      children: [ // Mensaje cuando no se encuentran actores
                        const SizedBox(height: 120),
                        SvgPicture.asset(
                          'assets/no.svg',
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'No actors found 😢',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Opacity(
                          opacity: .8,
                          child: Text( // Sugerencia para mejorar la búsqueda
                            'Try searching by full name or partial name.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox( // Lista horizontal de actores encontrados
                    height: 300,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.foundedActors.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 24),
                      itemBuilder: (_, index) {
                        Actor actor = controller.foundedActors[index];
                        return GestureDetector( // Detectar toque en el actor
                          onTap: () => Get.to(
                            ActorDetailsScreen(actorId: actor.id), // Navegar a la pantalla de detalles del actor al tocar
                          ),
                          child: TopRatedActorItem( // Mostrar información del actor
                            actor: actor,
                            index: index,
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
