// Importaciones necesarias
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/details_screen.dart';

class TabBuilder extends StatelessWidget { // Widget personalizado para construir una pestaña con películas
  const TabBuilder({
    required this.future,
    super.key,
  }); // Constructor que recibe una función de una lista de películas
  final Future<List<Movie>?> future; // Función que contiene la lista de películas
  @override
  Widget build(BuildContext context) { // Método build para construir el widget
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
      child: FutureBuilder<List<Movie>?>( // Se encarga de esperar la lista de películas obtenida de forma asíncrona y mostrar el contenido cuando este disponible
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder( // GridView para mostrar las películas en una cuadrícula
              physics: const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( 
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.6,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.to(DetailsScreen(movie: snapshot.data![index])); // Navega a la pantalla de detalles al tocar una película
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}', // Carga la imagen de la película desde la URL
                    height: 300,
                    width: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      size: 180,
                    ),
                    loadingBuilder: (_, __, ___) {
                      // ignore: no_wildcard_variable_uses
                      if (___ == null) return __;
                      return const FadeShimmer(
                        width: 180,
                        height: 250,
                        highlightColor: Color(0xff22272f),
                        baseColor: Color(0xff20252d),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los datos
            );
          }
        },
      ),
    );
  }
}
