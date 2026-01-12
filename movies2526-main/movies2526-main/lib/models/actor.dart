class Actor {
  final int id;
  final String name;
  final String? profilePath;
  final String? biography;
  final String? birthday;
  final String? placeOfBirth;
  final double popularity;

  Actor({
    required this.id,
    required this.name,
    this.profilePath,
    this.biography,
    this.birthday,
    this.placeOfBirth,
    required this.popularity,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'],
      name: map['name'] ?? '',
      profilePath: map['profile_path'] != null ? map['profile_path'] as String : null,
      biography: map['biography'],
      birthday: map['birthday'],
      placeOfBirth: map['place_of_birth'],
      popularity: (map['popularity'] ?? 0).toDouble(),
    );
  }
  
  String? get profileImageUrl {
    if (profilePath == null || profilePath!.isEmpty) return null;
    return 'https://image.tmdb.org/t/p/w500$profilePath';
  }
} 