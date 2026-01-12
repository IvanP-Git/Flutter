// Importaciones necesarias
import 'dart:convert';

class Movie { // Representa una película
  int id; // ID único de la película
  String title; // Título de la película
  String posterPath; // Ruta del póster de la película
  String backdropPath; // Ruta del fondo de la película
  String overview; // Resumen de la película
  String releaseDate; // Fecha de lanzamiento de la película
  double voteAverage; // Promedio de votos de la película
  List<int> genreIds; // Lista de IDs de géneros asociados a la película
  Movie({ // Constructor de la clase Movie
    required this.id, // ID obligatorio
    required this.title, // Título obligatorio
    required this.posterPath, // Ruta del póster obligatoria
    required this.backdropPath, // Ruta del fondo obligatoria
    required this.overview, // Resumen obligatorio
    required this.releaseDate, // Fecha de lanzamiento obligatoria
    required this.voteAverage, // Promedio de votos obligatorio
    required this.genreIds, // Lista de IDs de géneros obligatoria
  });

  factory Movie.fromMap(Map<String, dynamic> map) { // Fábrica para crear una instancia de Movie desde un mapa
    return Movie( // Retorna una nueva instancia de Movie
      id: map['id'] as int, // Asigna el ID desde el mapa
      title: map['title'] ?? '', // Asigna el título desde el mapa, o una cadena vacía si es nulo
      posterPath: map['poster_path'] ?? '', // Asigna la ruta del póster desde el mapa, o una cadena vacía si es nulo
      backdropPath: map['backdrop_path'] ?? '', // Asigna la ruta del fondo desde el mapa, o una cadena vacía si es nulo
      overview: map['overview'] ?? '', // Asigna el resumen desde el mapa, o una cadena vacía si es nulo
      releaseDate: map['release_date'] ?? '', // Asigna la fecha de lanzamiento desde el mapa, o una cadena vacía si es nulo
      voteAverage: map['vote_average']?.toDouble() ?? 0.0, // Asigna el promedio de votos desde el mapa, convirtiéndolo a double, o 0.0 si es nulo
      genreIds: List<int>.from(map['genre_ids']), // Asigna la lista de IDs de géneros desde el mapa
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source)); // Fábrica para crear una instancia de Movie desde una cadena JSON
}
