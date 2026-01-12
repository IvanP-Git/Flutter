// Importaciones necesarias
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/screens/actor_details_screen.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/widgets/infos.dart';
import 'package:movies/widgets/search_box.dart';

class SearchScreen extends StatefulWidget { // Pantalla de búsqueda
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState(); // Crear el estado asociado
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) { // Construir la interfaz de usuario
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
        child: Column(
          children: [
            Row( // Fila con botón de retroceso, título e ícono de información
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
                const Tooltip( // Ícono de información con descripción
                  message: 'Search your wanted movie here !',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SearchBox( // Caja de búsqueda para ingresar el término de búsqueda
              onSumbit: () { // Acción al enviar la búsqueda
                final ctrl = Get.find<SearchController1>();
                String search = ctrl.searchController.text;
                ctrl.searchController.text = '';
                if (ctrl.isActorSearch.value) {
                  ctrl.searchActors(search);
                } else {
                  ctrl.search(search);
                }
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(
              height: 34,
            ),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: GestureDetector( // Detectar toque en la opción de películas
                      onTap: () => Get.find<SearchController1>().isActorSearch.value = false,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Get.find<SearchController1>().isActorSearch.value ? const Color(0xFF3A3F47) : const Color(0xFF0296E5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center( // Centrar el texto
                          child: Text('Movies', style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector( // Detectar toque en la opción de actores
                      onTap: () => Get.find<SearchController1>().isActorSearch.value = true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Get.find<SearchController1>().isActorSearch.value ? const Color(0xFF0296E5) : const Color(0xFF3A3F47),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center( // Centrar el texto
                          child: Text('Actors', style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx(
              (() { // Observar cambios en el estado del controlador
                final controller = Get.find<SearchController1>();
                if (controller.isLoading.value) return const CircularProgressIndicator();

                if (controller.isActorSearch.value) {
                  if (!controller.hasSearchedActors.value) {
                    return SizedBox( // Mensaje inicial antes de buscar actores
                      width: Get.width / 1.5,
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          SvgPicture.asset('assets/no.svg', height: 120, width: 120),
                          const SizedBox(height: 10),
                          const Text( 
                            'Busca actores por nombre',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }

                  if (controller.foundedActors.isEmpty) {
                    return SizedBox(
                      width: Get.width / 1.5,
                      child: Column(
                        children: [ // Mensaje cuando no se encuentran actores
                          const SizedBox(height: 120),
                          SvgPicture.asset('assets/no.svg', height: 120, width: 120),
                          const SizedBox(height: 10),
                          const Text(
                            'No actors found :(',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated( // Lista vertical de actores encontrados
                    itemCount: controller.foundedActors.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(height: 24),
                    itemBuilder: (_, index) {
                      final actor = controller.foundedActors[index];
                      return GestureDetector( // Detectar toque en el actor
                        onTap: () => Get.to(() => ActorDetailsScreen(actorId: actor.id)),
                        child: Row(
                          children: [
                            ClipRRect( // Imagen del actor
                              borderRadius: BorderRadius.circular(12),
                              child: actor.profileImageUrl != null
                                  ? Image.network(actor.profileImageUrl!, height: 120, width: 90, fit: BoxFit.cover)
                                  : Container(width: 90, height: 120, color: const Color(0xFF20252d), child: const Icon(Icons.person)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Text(actor.name, style: const TextStyle(fontSize: 16))),
                          ],
                        ),
                      );
                    },
                  );
                }

                if (!controller.hasSearchedMovies.value) { // Antes de realizar una búsqueda de películas
                  return SizedBox(
                    width: Get.width / 1.5,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        SvgPicture.asset(
                          'assets/no.svg',
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text( // Mensaje inicial antes de buscar películas
                          'Busca una película por título, año o categoría',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        const Opacity(
                          opacity: .8,
                          child: Text( // Sugerencia para mejorar la búsqueda
                            'Ejemplo: "Inception" o "2019"',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return controller.foundedMovies.isEmpty
                    ? SizedBox( // Mensaje cuando no se encuentran películas
                        width: Get.width / 1.5,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 120,
                            ),
                            SvgPicture.asset(
                              'assets/no.svg',
                              height: 120,
                              width: 120,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text( // Mensaje de no encontrado
                              'We Are Sorry, We Can Not Find The Movie :(',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                wordSpacing: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Opacity(
                              opacity: .8,
                              child: Text( // Sugerencia para mejorar la búsqueda
                                'Find your movie by Type title, categories, years, etc ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated( // Lista vertical de películas encontradas
                        itemCount: controller.foundedMovies.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 24),
                        itemBuilder: (_, index) {
                          Movie movie = controller.foundedMovies[index];
                          return GestureDetector( // Detectar toque en la película
                            onTap: () => Get.to(DetailsScreen(movie: movie)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [ // Contenedor con imagen y detalles de la película
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network( // Imagen del póster de la película
                                    Api.imageBaseUrl + movie.posterPath,
                                    height: 180,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.broken_image,
                                      size: 120,
                                    ),
                                    loadingBuilder: (_, __, ___) {
                                      // ignore: no_wildcard_variable_uses
                                      if (___ == null) return __;
                                      return const FadeShimmer(
                                        width: 120,
                                        height: 180,
                                        highlightColor: Color(0xff22272f),
                                        baseColor: Color(0xff20252d),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Infos(movie: movie) // Mostrar información de la película
                              ],
                            ),
                          );
                        });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
