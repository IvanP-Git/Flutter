// Importaciones necesarias
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/screens/actor_details_screen.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/widgets/infos.dart';
import 'package:movies/widgets/actor_infos.dart';

class WatchList extends StatelessWidget { // Pantalla de lista de seguimiento
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) { // Construcción del widget
    return Obx(() => SingleChildScrollView( 
          child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Column(
              children: [ // Contenido de la pantalla
                Row(
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
                      'Watch list',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 33,
                      height: 33,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                if (Get.find<MoviesController>().watchListMovies.isNotEmpty) // Películas en la lista de seguimiento
                  ...Get.find<MoviesController>().watchListMovies.map( // Iterar sobre las películas en la lista de seguimiento
                        (movie) => Column(
                          children: [
                            GestureDetector( // Detectar toque en la película
                              onTap: () => Get.to(DetailsScreen(movie: movie)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [ // Contenido de cada película
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network( // Imagen del póster de la película
                                      Api.imageBaseUrl + movie.posterPath,
                                      height: 180,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.broken_image,
                                        size: 180,
                                      ),
                                      loadingBuilder: (_, __, ___) {
                                        // ignore: no_wildcard_variable_uses
                                        if (___ == null) return __;
                                        return const FadeShimmer(
                                          width: 150,
                                          height: 150,
                                          highlightColor: Color(0xff22272f),
                                          baseColor: Color(0xff20252d),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Infos(movie: movie) // Información de la película
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),

                Builder(builder: (_) { // Actores en la lista de seguimiento
                  final moviesCtrl = Get.find<MoviesController>();
                  List actorList = [];
                  actorList.addAll(moviesCtrl.watchListActors);
                  try { // Evitar duplicados
                    final actorsCtrl = Get.find<ActorsController>();
                    actorList.addAll(actorsCtrl.watchListActors.where((a) => !actorList.any((b) => b.id == a.id)));
                  } catch (_) {}

                  if (actorList.isEmpty) return const SizedBox.shrink();

                  return Column(
                    children: [
                      ...actorList.map( // Iterar sobre los actores en la lista de seguimiento
                            (actor) => Column(
                              children: [
                                GestureDetector( // Detectar toque en el actor
                                  onTap: () => Get.to(() => ActorDetailsScreen(actorId: actor.id)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [ // Contenido de cada actor
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network( // Imagen del actor
                                          actor.profileImageUrl ?? 'https://via.placeholder.com/100',
                                          height: 180,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => const Icon(
                                            Icons.person,
                                            size: 180,
                                          ),
                                          loadingBuilder: (_, __, ___) {
                                            if (___ == null) return __;
                                            return const FadeShimmer(
                                              width: 150,
                                              height: 150,
                                              highlightColor: Color(0xff22272f),
                                              baseColor: Color(0xff20252d),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      ActorInfos(actor: actor) // Información del actor
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                    ],
                  );
                }),

                if (Get.find<MoviesController>().watchListMovies.isEmpty && Get.find<MoviesController>().watchListActors.isEmpty)
                  const SizedBox.shrink(), // Mostrar espacio vacío si no hay elementos en la lista de seguimiento
              ],
            ),
          ),
        ));
  }
}
