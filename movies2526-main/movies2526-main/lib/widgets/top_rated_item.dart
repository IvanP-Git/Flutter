// Importaciones necesarias
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/widgets/index_number.dart';

class TopRatedItem extends StatelessWidget { // Widget para mostrar una película mejor valorada
  const TopRatedItem({
    super.key,
    required this.movie,
    required this.index,
  }); // Constructor con parámetros obligatorios

  final Movie movie; // Película a mostrar
  final int index; // Índice de la película en la lista
  @override
  Widget build(BuildContext context) { // Método build para construir el widget
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(
            DetailsScreen(movie: movie), // Navegar a la pantalla de detalles de la película al hacer clic
          ),
          child: Container( // Contenedor para la imagen de la película
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network( // Mostrar la imagen de la película
                Api.imageBaseUrl + movie.posterPath,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
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
        ),
        Align(
          alignment: Alignment.bottomLeft, // Alinear el número de índice en la parte inferior izquierda
          child: IndexNumber(number: index), // Widget personalizado para mostrar el número de índice
        )
      ],
    );
  }
}
