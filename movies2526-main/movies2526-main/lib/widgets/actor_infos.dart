// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:movies/models/actor.dart';

class ActorInfos extends StatelessWidget { // Widget para mostrar información del actor
  const ActorInfos({super.key, required this.actor}); // Constructor con parámetro requerido
  final Actor actor; // Propiedad para almacenar la información del actor

  @override
  Widget build(BuildContext context) { // Método build para construir el widget
    return SizedBox( // Contenedor vertical completo de la información del actor
      height: 180,
      child: Column( // Organiza todo el texto del actor de arriba a abajo
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            child: Text( // Representa el nombre del actor
              actor.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Column( // Representa toda la información secundaria del actor
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, color: Color(0xFFFF8700)),
                  const SizedBox(width: 8),
                  Text( // Representa la fecha de nacimiento del actor
                    actor.birthday ?? 'N/A',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.place, size: 16),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 160,
                    child: Text( // Representa el lugar de nacimiento del actor
                      actor.placeOfBirth ?? 'Unknown',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.trending_up, size: 16, color: Color(0xFFFF8700)),
                  const SizedBox(width: 8),
                  Text( // Representa la popularidad del actor
                    actor.popularity.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: Color(0xFFFF8700)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
