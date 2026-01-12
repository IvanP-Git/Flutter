// Importaciones necesarias
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/actor_details_screen.dart';
import 'package:movies/widgets/index_number.dart';

class TopRatedActorItem extends StatelessWidget { // Widget para mostrar un actor mejor valorado
  const TopRatedActorItem({
    super.key,
    required this.actor,
    required this.index,
  }); // Constructor con parámetros obligatorios

  final Actor actor; // Actor a mostrar
  final int index; // Índice del actor en la lista

  @override
  Widget build(BuildContext context) { // Método build para construir el widget
    return Stack( 
      children: [
        GestureDetector(
          onTap: () => Get.to(
            ActorDetailsScreen(actorId: actor.id), // Navegar a la pantalla de detalles del actor al hacer clic
          ),
          child: Container( // Contenedor para la imagen del actor
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: actor.profileImageUrl != null
                ? Image.network( // Mostrar la imagen del actor si está disponible
                    actor.profileImageUrl!,
                    fit: BoxFit.cover,
                    height: 250,
                    width: 180,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.person,
                  size: 180,
                ),
                loadingBuilder: (_, __, ___) {
                  if (___ == null) return __;
                  return const FadeShimmer(
                    width: 180,
                    height: 250,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ) : const SizedBox( // Mostrar un icono por defecto si no hay imagen disponible
                height: 250,
                width: 180,
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft, // Alinear el número de índice en la parte inferior izquierda
          child: IndexNumber(number: index), // Widget personalizado para mostrar el número de índice
        ),
      ],
    );
  }
}
