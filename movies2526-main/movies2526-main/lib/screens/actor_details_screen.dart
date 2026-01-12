// Importaciones necesarias
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/actors_controller.dart';

class ActorDetailsScreen extends StatelessWidget { // Pantalla de detalles del actor
  final int actorId; // ID del actor a mostrar
  const ActorDetailsScreen({super.key, required this.actorId}); 

  @override
  Widget build(BuildContext context) { // Construcción de la interfaz
    return FutureBuilder<Actor?>( 
      future: ApiService.getActorDetails(actorId), // Obtener detalles del actor desde la API
      builder: (_, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final actor = snapshot.data!;
        final moviesCtrl = Get.find<MoviesController>();

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [ // Contenido principal (appbar, foto, nombre, biografía, créditos)
                  Padding( // AppBar personalizado
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: SizedBox(
                      height: kToolbarHeight,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.centerLeft, child: const BackButton(color: Colors.white)),
                          Center(
                            child: Text(
                              'Detail',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align( // Botón para agregar/quitar de la watchlist
                            alignment: Alignment.centerRight,
                            child: Obx(() {
                              bool saved = moviesCtrl.watchListActors.any((a) => a.id == actor.id);
                              try {
                                final actorsCtrl = Get.find<ActorsController>();
                                if (actorsCtrl.watchListActors.any((a) => a.id == actor.id)) saved = true;
                              } catch (_) {}
                              return IconButton(
                                tooltip: saved ? 'Remove from watch list' : 'Add to watch list',
                                onPressed: () => moviesCtrl.addToWatchListActor(actor),
                                icon: Icon(
                                  saved ? Icons.star : Icons.star_border,
                                  color: saved ? Colors.amber : Colors.white,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox( // Foto grande del actor
                    height: 240,
                    width: Get.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: actor.profileImageUrl != null
                          ? Image.network( // Cargar imagen del actor
                              actor.profileImageUrl!,
                              width: Get.width,
                              height: 240,
                              fit: BoxFit.fitHeight,
                              alignment: const Alignment(0, -0.45),
                              loadingBuilder: (_, __, ___) {
                                if (___ == null) return __;
                                return const FadeShimmer(
                                  width: double.infinity,
                                  height: 240,
                                  highlightColor: Color(0xff22272f),
                                  baseColor: Color(0xff20252d),
                                );
                              },
                              errorBuilder: (_, __, ___) => Image.network( // Imagen por defecto si hay error
                                'https://via.placeholder.com/500',
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Image.network( // Imagen por defecto si no hay URL
                              'https://via.placeholder.com/500',
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Padding( // Nombre del actor + foto pequeña
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network( // Foto pequeña del actor
                            actor.profileImageUrl ?? 'https://via.placeholder.com/200',
                            width: 96,
                            height: 128,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.center,
                            loadingBuilder: (_, __, ___) {
                              if (___ == null) return __;
                              return const FadeShimmer(
                                width: 96,
                                height: 128,
                                highlightColor: Color(0xff22272f),
                                baseColor: Color(0xff20252d),
                              );
                            },
                            errorBuilder: (_, __, ___) => Image.network( // Imagen por defecto si hay error
                              'https://via.placeholder.com/200',
                              width: 96,
                              height: 128,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded( // Nombre del actor
                          child: Text(
                            actor.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Opacity( 
                    opacity: 0.7,
                    child: Center(
                      child: SizedBox(  // Fecha de nacimiento | Lugar de nacimiento
                        width: Get.width * 0.7,
                        height: 22,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [ // Usamos Stack para centrar el separador '|'
                            if (actor.birthday != null && actor.placeOfBirth != null)
                              const Center(
                                child: Text('|', style: TextStyle(fontSize: 13)),
                              ),
                            Row( 
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                actor.birthday != null
                                    ? Text( // Fecha de nacimiento
                                        actor.birthday!, 
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                                      )
                                    : const SizedBox.shrink(),
                                actor.placeOfBirth != null
                                    ? Flexible(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text( // Lugar de nacimiento
                                            actor.placeOfBirth!,
                                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Padding( // Pestañas: Biografía y Créditos
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          const TabBar(
                            indicatorColor: Color(0xFF3A3F47),
                            indicatorWeight: 4,
                            tabs: [
                              Tab(text: 'Biography'),
                              Tab(text: 'Known For'),
                            ],
                          ),
                          SizedBox(
                            height: 400,
                            child: TabBarView(
                              children: [ // Contenido de las pestañas
                                SingleChildScrollView(
                                  padding: const EdgeInsets.all(10),
                                  child: Text( // Biografía del actor
                                    actor.biography ?? 'No biography available',
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ),

                                FutureBuilder<List<Movie>?>( // Créditos del actor
                                  future: ApiService.getActorMovies(actor.id), // Obtener películas del actor desde la API
                                  builder: (_, snapshotMovies) {
                                    if (!snapshotMovies.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final movies = snapshotMovies.data!;
                                    if (movies.isEmpty) {
                                      return const Center(child: Text('No movies found'));
                                    }
                                    return SizedBox( // Lista horizontal de películas
                                      height: 250,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: movies.length,
                                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                                        itemBuilder: (_, index) {
                                          final movie = movies[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Get.to(() => DetailsScreen(movie: movie)); // Navegación a la pantalla de detalles de la película
                                            },
                                            child: Tooltip( // Descripción con el título de la película
                                              message: movie.title,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(16),
                                                child: Image.network( // Poster de la película
                                                  'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                                                  width: 150,
                                                  height: 220,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (_, __, ___) {
                                                    if (___ == null) return __;
                                                    return const FadeShimmer(
                                                      width: 150,
                                                      height: 220,
                                                      highlightColor: Color(0xff22272f),
                                                      baseColor: Color(0xff20252d),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}