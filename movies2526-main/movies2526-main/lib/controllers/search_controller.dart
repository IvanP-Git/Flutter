// Importaciones necesarias
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/actor.dart';

class SearchController1 extends GetxController { // Controlador para la búsqueda de peliículas y actores
  TextEditingController searchController = TextEditingController(); // Controlador para el campo de búsqueda
  var searchText = ''.obs; // Texto de búsqueda observable
  var foundedMovies = <Movie>[].obs; // Lista de películas encontradas
  var foundedActors = <Actor>[].obs; // Lista de actores encontrados
  var isLoading = false.obs; // Indicador de carga
  var isActorSearch = false.obs; // Indicador de búsqueda de actores
  var hasSearchedMovies = false.obs; // Indicador de si se ha buscado películas
  var hasSearchedActors = false.obs; // Indicador de si se ha buscado actores

  void setSearchText(text) => searchText.value = text; // Actualiza el texto de búsqueda

  void search(String query) async { // Función para buscar películas
    isActorSearch.value = false; // Indicador de búsqueda de películas
    isLoading.value = true; // Inicia la carga
    foundedMovies.value = (await ApiService.getSearchedMovies(query)) ?? []; // Obtiene las películas buscadas
    hasSearchedMovies.value = true; // Marca que se ha realizado una búsqueda de películas
    isLoading.value = false; // Finaliza la carga
    searchController.text = ''; // Limpia el campo de búsqueda
  }

  void searchActors(String query) async { // Función para buscar actores
    isActorSearch.value = true; // Indicador de búsqueda de actores
    isLoading.value = true; // Inicia la carga
    foundedActors.value = (await ApiService.getSearchedActors(query)) ?? []; // Obtiene los actores buscados
    hasSearchedActors.value = true; // Marca que se ha realizado una búsqueda de actores
    isLoading.value = false; // Finaliza la carga
    searchController.text = ''; // Limpia el campo de búsqueda
  }
}
