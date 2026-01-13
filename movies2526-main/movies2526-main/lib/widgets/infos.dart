// Importaciones necesarias
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/utils/utils.dart';

class Infos extends StatelessWidget { // Widget para mostrar información de una película
  const Infos({super.key, required this.movie}); // Constructor con parámetro requerido 'movie'
  final Movie movie; // Objeto Movie que contiene la información de la película
  @override
  Widget build(BuildContext context) { // Método build para construir el widget
    return SizedBox( // Contenedor vertical completo de la información de la película
      height: 180,
      child: Column( // Organiza todo el texto de la película de arriba a abajo
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            child: Text( // Representa el título de la película
              movie.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Column( // Representa toda la información secundaria de la película
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/Star.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text( // Representa el voto promedio de la película
                    movie.voteAverage == 0.0
                        ? 'N/A'
                        : movie.voteAverage.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFFFF8700),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/Ticket.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text( // Representa los géneros de la película
                    Utils.getGenres(movie),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/calender.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text( // Representa el año de lanzamiento de la película
                    movie.releaseDate.split('-')[0],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
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
