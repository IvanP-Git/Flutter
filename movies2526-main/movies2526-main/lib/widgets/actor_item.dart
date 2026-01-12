// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:get/get.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/actor_details_screen.dart';

class ActorItem extends StatelessWidget { // Widget para mostrar un actor en una lista
  final Actor actor; // Propiedad para almacenar la información del actor
  const ActorItem({ 
    super.key,
    required this.actor
  }); // Constructor con parámetro requerido
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ActorDetailsScreen(actorId: actor.id)), // Navega a la pantalla de detalles del actor al tocar
      child: Container( // Tarjeta completa del actor
        padding: const EdgeInsets.all(8.0),
        width: 135,
        child: Column( // Organiza la imagen y el nombre del actor verticalmente
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: actor.profileImageUrl != null 
                  ? Image.network( // Muestra la imagen del actor si está disponible
                      actor.profileImageUrl!,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        size: 180,
                      ),
                      loadingBuilder: (_, __, ___) {
                        // ignore: no_wildcard_variable_uses
                        if (___ == null) return __;
                        return const FadeShimmer(
                          width: 135,
                          height: 180,
                          highlightColor: Color(0xff22272f),
                          baseColor: Color(0xff20252d),
                        );
                      }
                    )
                  : const SizedBox( // Muestra un icono de imagen rota si no hay imagen disponible
                      height: 180,
                      width: 135,
                      child: Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 60,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 5,), // Espacio entre la imagen y el nombre
            Text(actor.name, maxLines: 2 ), // Muestra el nombre del actor
          ],
        ),
      ),
    );
  }
}