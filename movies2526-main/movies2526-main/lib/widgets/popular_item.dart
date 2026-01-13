// Importaciones necesarias
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/widgets/index_number.dart';

class PopularItem extends StatelessWidget { // Widget para mostrar un actor popular
  const PopularItem({
    super.key,
    required this.actor,
    required this.index,
  }); // Constructor con parámetros requeridos 'actor' e 'index'

  final Actor actor; // Objeto Actor que contiene la información del actor
  final int index; // Índice del actor en la lista
  @override
  Widget build(BuildContext context) { // Método build para construir el widget
    return Stack( // Contenedor apilado para mostrar la imagen del actor y su índice
      children: [ 
        Container( // Contenedor para la imagen del actor
          margin: const EdgeInsets.only(left: 12),
          child: ClipRRect( 
            borderRadius: BorderRadius.circular(16),
            child: actor.profileImageUrl != null
                ? Image.network( // Muestra la imagen del actor si está disponible
                    actor.profileImageUrl!,
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
                  )
                : const SizedBox( // Muestra un icono de imagen rota si no hay imagen disponible
                    height: 250,
                    width: 180,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 80,
                      ),
                    ),
                  ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft, // Alinea el índice en la esquina inferior izquierda
          child: IndexNumber(number: index), // Muestra el índice del actor en la esquina inferior izquierda
        )
      ],
    );
  }
}
