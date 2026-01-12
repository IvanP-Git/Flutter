// Importaciones necesarias
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/movies_controller.dart';

import 'package:movies/models/movie.dart';
import 'package:movies/models/review.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/actor_details_screen.dart';
import 'package:movies/utils/utils.dart';

class DetailsScreen extends StatelessWidget { // Pantalla de detalles de la película
  const DetailsScreen({
    super.key,
    required this.movie,
  });
  final Movie movie; // Película cuyos detalles se mostrarán
  @override
  Widget build(BuildContext context) {
    ApiService.getMovieReviews(movie.id); // Obtener reseñas de la película
    return SafeArea( 
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding( // Barra superior con botón de retroceso, título y marcador
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton( // Botón de retroceso
                      tooltip: 'Back to home',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text( // Título "Detail"
                      'Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    Tooltip( // Icono de marcador para agregar a la lista de seguimiento
                      message: 'Save this movie to your watch list',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<MoviesController>().addToWatchList(movie); // Agregar o quitar de la lista de seguimiento
                        
                        },
                        icon: Obx( // Icono reactivo que cambia según si la película está en la lista de seguimiento
                          () =>
                              Get.find<MoviesController>().isInWatchList(movie) // Verificar si la película está en la lista de seguimiento
                                  ? const Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 33,
                                    )
                                  : const Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.white,
                                      size: 33,
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [ // Imagen de fondo, póster, título y calificación
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network( // Imagen de fondo
                        Api.imageBaseUrl + movie.backdropPath,
                        width: Get.width,
                        height: 250,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, __, ___) {
                          // ignore: no_wildcard_variable_uses
                          if (___ == null) return __;
                          return FadeShimmer(
                            width: Get.width,
                            height: 250,
                            highlightColor: const Color(0xff22272f),
                            baseColor: const Color(0xff20252d),
                          );
                        },
                        errorBuilder: (_, __, ___) => const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image,
                            size: 250,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network( // Póster de la película
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, __, ___) {
                              // ignore: no_wildcard_variable_uses
                              if (___ == null) return __;
                              return const FadeShimmer(
                                width: 110,
                                height: 140,
                                highlightColor: Color(0xff22272f),
                                baseColor: Color(0xff20252d),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned( // Título de la película
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Positioned( // Calificación de la película
                      top: 200,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(37, 40, 54, 0.52),
                        ),
                        child: Row(
                          children: [ // Icono de estrella y valor de la calificación
                            SvgPicture.asset('assets/Star.svg'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              movie.voteAverage == 0.0
                                  ? 'N/A'
                                  : movie.voteAverage.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF8700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Opacity(
                opacity: .6,
                child: SizedBox(
                  width: Get.width / 1.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/calender.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text( // Año de lanzamiento
                            movie.releaseDate.split('-')[0],
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const Text('|'), // Separador
                      Row(
                        children: [
                          SvgPicture.asset('assets/Ticket.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text( // Géneros de la película
                            Utils.getGenres(movie),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [ // Pestañas: Sobre la película, Reseñas, Reparto
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(
                            0xFF3A3F47,
                          ),
                          tabs: [
                            Tab(text: 'About Movie'),
                            Tab(text: 'Reviews'),
                            Tab(text: 'Cast'),
                          ]),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          Container( // Pestaña "Sobre la película"
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              movie.overview,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                          FutureBuilder<List<Review>?>( // Pestaña "Reseñas"
                            future: ApiService.getMovieReviews(movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.isEmpty
                                    ? const Padding( // Mostrar "No review" si no hay reseñas
                                        padding: EdgeInsets.only(top: 30.0),
                                        child: Text(
                                          'No review',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : ListView.builder( // Lista de reseñas
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (_, index) => Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column( // Avatar y calificación del autor
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/avatar.svg',
                                                    height: 50,
                                                    width: 50,
                                                    // fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    snapshot.data![index].rating
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xff0296E5),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text( // Nombre del autor de la reseña
                                                    snapshot
                                                        .data![index].author,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox( // Comentario de la reseña
                                                    width: 245,
                                                    child: Text(snapshot
                                                        .data![index].comment,
                                                        style: const TextStyle(
                                                          fontSize: 8,
                                                          fontWeight:
                                                            FontWeight.w400,
                                                    ),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              } else {
                                return const Center(
                                  child: Text('Wait...'), // Mensaje mientras se cargan las reseñas
                                );
                              }
                            },
                          ),
                          FutureBuilder<List<Actor>?>( // Pestaña "Reparto"
                            future: ApiService.getMovieCast(movie.id), // Obtener reparto de la película desde la API
                            builder: (_, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) { // Mostrar indicador de carga mientras se obtienen los datos
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                print('Error in cast future: ${snapshot.error}');
                                return const Center(child: Text('Error loading cast'));
                              }

                              final cast = snapshot.data ?? [];
                              if (cast.isEmpty) return const Center(child: Text('No cast found')); // Mostrar mensaje si no hay reparto

                              try { // Construir la lista horizontal de actores
                                return SizedBox(
                                  height: 250,
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: cast.length,
                                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                                      itemBuilder: (_, index) {
                                        final actor = cast[index];
                                        return GestureDetector( // Navegar a la pantalla de detalles del actor al tocar
                                          onTap: () => Get.to(() => ActorDetailsScreen(actorId: actor.id)),
                                          child: SizedBox(
                                            width: 120,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: actor.profileImageUrl != null
                                                      ? Image.network( // Imagen del actor
                                                          actor.profileImageUrl!,
                                                          width: 120,
                                                          height: 160,
                                                          fit: BoxFit.cover,
                                                          loadingBuilder: (_, __, ___) {
                                                            if (___ == null) return __;
                                                            return const FadeShimmer(
                                                              width: 120,
                                                              height: 160,
                                                              highlightColor: Color(0xff22272f),
                                                              baseColor: Color(0xff20252d),
                                                            );
                                                          },
                                                        )
                                                      : const SizedBox( // Icono de persona si no hay imagen disponible
                                                          width: 120,
                                                          height: 160,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.person,
                                                              size: 50,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text( // Nombre del actor
                                                  actor.name,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } catch (e) {
                                print('Error building cast list: $e');
                                return const Center(child: Text('Error showing cast'));
                              }
                            },
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}