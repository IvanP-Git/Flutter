class Review { // Representa una reseña de una película
  String author; // Nombre del autor de la reseña
  String comment; // Contenido de la reseña
  double rating; // Calificación dada en la reseña
  Review({ // Constructor de la clase Review
    required this.author, // Nombre del autor obligatorio
    required this.comment, // Contenido de la reseña obligatorio
    required this.rating, // Calificación obligatoria
  });

  factory Review.fromJson(Map<String, dynamic> map) { // Fábrica para crear una instancia de Review desde un mapa
    return Review( // Retorna una nueva instancia de Review
      author: map['name'] ?? '', // Asigna el nombre del autor desde el mapa, o una cadena vacía si es nulo
      comment: map['content'] ?? '', // Asigna el contenido de la reseña desde el mapa, o una cadena vacía si es nulo
      rating: map['rating']?.toDouble() ?? 0.0, // Asigna la calificación desde el mapa, convirtiéndola a double, o 0.0 si es nulo
    );
  }
}
