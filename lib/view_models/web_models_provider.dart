import 'package:flutter/foundation.dart';
import 'package:peliculas/services/webservices.dart';

import '../models/comics.dart';
import '../models/peliculas.dart';
import '../models/series.dart';
import '../models/stories.dart';

/// Clase WebserviceProvider que actúa como un proveedor de servicios web.
/// Proporciona métodos para realizar diversas llamadas a servicios web utilizando la clase Webservice interna.
/// Extiende ChangeNotifier para permitir la notificación de cambios a los consumidores.
class WebserviceProvider with ChangeNotifier {
  final Webservice _webservice = Webservice();

  /// Obtiene la lista de películas.
  Future<Peliculas?> fetchMovies() {
    return _webservice.fetchMovies();
  }

  /// Obtiene los cómics relacionados con un personaje específico.
  Future<Comicst> fetchComics(int characterId, String history) {
    return _webservice.fetchComics(characterId, history);
  }

  /// Obtiene las historias relacionadas con un personaje específico.
  Future<Storiest> fetchStories(int characterId, String history) {
    return _webservice.fetchStories(characterId, history);
  }

  /// Obtiene las series relacionadas con un personaje específico.
  Future<Seriest> fetchSeries(int characterId, String history) {
    return _webservice.fetchSeries(characterId, history);
  }

  /// Obtiene los cómics relacionados con un historial específico.
  Future<Comicst> fetchComicsTo(String history) {
    return _webservice.fetchComicsTo(history);
  }

  /// Obtiene las series relacionadas con un historial específico.
  Future<Seriest> fetchSeriesTo(String history) {
    return _webservice.fetchSeriesTo(history);
  }

  /// Obtiene las historias relacionadas con un historial específico.
  Future<Storiest> fetchStoriesTo(String history) {
    return _webservice.fetchStoriesTo(history);
  }
}
