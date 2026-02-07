class Subject { // Clase que representa una materia, con sus atributos y sus métodos
  int? id;
  int? userId;
  String? title;
  String? description;
  String? createdAt;

  Subject({this.id, this.userId, this.title, this.description, this.createdAt});

  Subject.fromJson(Map<String, dynamic> json) { // Método que convierte un JSON en un objeto de la clase Subject
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() { // Método que convierte un objeto de la clase Subject en un JSON
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    return data;
  }

  static List<Subject> fromJsonList(List? data) { // Método estático que convierte una lista de JSON en una lista de objetos de la clase Subject
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Subject.fromJson(e)).toList();
  }
}