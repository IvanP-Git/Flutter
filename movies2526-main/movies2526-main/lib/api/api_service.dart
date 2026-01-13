import 'dart:convert';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_end_points.dart';
import 'package:movies/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/review.dart';
import 'package:movies/models/actor.dart';

class ApiService {
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/top_rated?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getSearchedMovies(String query) async {
    List<Movie> movies = [];
    try {
      final encoded = Uri.encodeQueryComponent(query);
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}search/movie?api_key=${Api.apiKey}&language=en-US&query=$encoded&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      if (res == null || res['results'] == null) return movies;
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Actor>?> getPopularActors() async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}${ApiEndPoint.popularActors}?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (a) => actors.add(
              Actor.fromMap(a),
            ),
          );
      return actors;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Actor>?> getMorePopularActors() async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}${ApiEndPoint.popularActors}?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).forEach(
            (a) => actors.add(
              Actor.fromMap(a),
            ),
          );
      return actors;
    } catch (e) {
      return null;
    }
  }
  
  static Future<Actor?> getActorDetails(int actorId) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          '${Api.baseUrl}person/$actorId?api_key=${Api.apiKey}&language=en-US',
        ),
      );
      var res = jsonDecode(response.body);
      return Actor.fromMap(res);
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>> getActorMovies(int actorId) async {
  List<Movie> movies = [];
  try {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}person/$actorId/movie_credits?api_key=${Api.apiKey}&language=en-US'),
    );
    final res = jsonDecode(response.body);
    if (res == null || res['cast'] == null) return movies;

    for (var m in res['cast']) {
      try {
        movies.add(Movie.fromMap(m));
      } catch (e) {
        print('Warning: failed to parse movie entry: $e');
        continue;
      }
    }
    return movies; // devuelve siempre lista (vacía si no hay datos)
  } catch (e) {
    print('Error fetching actor movies: $e');
    return movies;
  }
}

  static Future<List<Actor>?> getMovieCast(int movieId) async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(
        Uri.parse(
          '${Api.baseUrl}movie/$movieId/credits?api_key=${Api.apiKey}&language=en-US',
        ),
      );
      var res = jsonDecode(response.body);
      if (res == null || res['cast'] == null) return actors;
      for (var a in res['cast']) {
        try {
          actors.add(Actor.fromMap(a));
        } catch (e) {
          // ignore malformed actor entry and continue
          print('Warning: failed to parse actor entry: $e');
          continue;
        }
      }
      return actors;
    } catch (e) {
      print('Error fetching cast: $e');
      return null;
    }
  }

  static Future<List<Actor>?> getSearchedActors(String query) async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(
        Uri.parse(
          '${Api.baseUrl}search/person?api_key=${Api.apiKey}&language=en-US&query=$query&page=1&include_adult=false',
        ),
      );
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (a) => actors.add(
          Actor.fromMap(a),
        ),
      );

      return actors;
    } catch (e) {
      return null;
    }
  }
}