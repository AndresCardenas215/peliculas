import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:peliculas/models/series.dart';
import '../models/comics.dart';
import '../models/peliculas.dart';
import '../models/stories.dart';

/// Clase Webservice que se encarga de realizar llamadas a servicios web para obtener datos relacionados con películas, cómics, historias y series.
/// Utiliza una clave pública y una clave privada proporcionadas por Marvel para autenticar las solicitudes.
/// Extiende ChangeNotifier para permitir la notificación de cambios a los consumidores.
class Webservice with ChangeNotifier {
  final String publicKey = 'fea4ddbf370376865724c2b03db5ffef';
  final String privateKey = 'dcca949708ec8a3a3b97cf51cacf65cd98a314c4';
  Peliculas? peliculas;

  /// Realiza una solicitud para obtener la lista de películas.
  /// Genera una marca de tiempo y un hash para autenticar la solicitud.
  /// Devuelve un objeto Future que representa los resultados de la solicitud.
  Future<Peliculas?> fetchMovies() async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateHash(timeStamp);
    final url = _buildUrl('characters', '', timeStamp, hash);

    final jsonResponse = await _fetchData(url);
    peliculas = Peliculas.fromJson(jsonResponse);
    return peliculas;
  }

  /// Realiza una solicitud para obtener los cómics relacionados con un personaje específico.
  /// Genera una marca de tiempo y un hash para autenticar la solicitud.
  /// Devuelve un objeto Future que representa los resultados de la solicitud.
  Future<Comicst> fetchComics(int characterId, String history) async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateHash(timeStamp);
    final url = _buildUrl('characters/$characterId/$history', '', timeStamp, hash);

    final jsonResponse = await _fetchData(url);
    final general = Comicst.fromJson(jsonResponse);
    return general;
  }

  /// Realiza una solicitud para obtener las historias relacionadas con un personaje específico.
  /// Genera una marca de tiempo y un hash para autenticar la solicitud.
  /// Devuelve un objeto Future que representa los resultados de la solicitud.
  Future<Storiest> fetchStories(int characterId, String history) async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateHash(timeStamp);
    final url = _buildUrl('characters/$characterId/$history', '', timeStamp, hash);

    final jsonResponse = await _fetchData(url);
    final general = Storiest.fromJson(jsonResponse);
    return general;
  }

  /// Realiza una solicitud para obtener las series relacionadas con un personaje específico.
  /// Genera una marca de tiempo y un hash para autenticar la solicitud.
  /// Devuelve un objeto Future que representa los resultados de la solicitud.
  Future<Seriest> fetchSeries(int characterId, String history) async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateHash(timeStamp);
    final url = _buildUrl('characters/$characterId/$history', '', timeStamp, hash);

    final jsonResponse = await _fetchData(url);
    final general = Seriest.fromJson(jsonResponse);
    return general;
  }

  /// Realiza una solicitud para obtener los cómics relacionados con un historial específico.
  /// Genera una marca de tiempo y un hash para autenticar la solicitud.
  /// Devuelve un objeto Future que representa los resultados de la solicitud.
  Future<Comicst> fetchComicsTo(String history) async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateHash(timeStamp);
    final url = _buildUrl(history, '', timeStamp, hash);

    final jsonResponse = await _fetchData(url);
    final general = Comicst.fromJson(jsonResponse);
    return general;
  }

  /// Realiza una solicitud para obtener las series relacionadas con un historial específico.
  /// Genera una marca de tiempo y un hash para autenticar la solicitud.
  /// Devuelve un objeto Future que representa los resultados de la solicitud.
  Future<Seriest> fetchSeriesTo(String history) async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateHash(timeStamp);
    final url = _buildUrl(history, '', timeStamp, hash);

    final jsonResponse = await _fetchData(url);
    final general = Seriest.fromJson(jsonResponse);
    return general;
  }

  /// Realiza una solicitud para obtener las historias relacionadas con un historial específico.
  /// Genera una marca de tiempo y un hash para autenticar la solicitud.
  /// Devuelve un objeto Future que representa los resultados de la solicitud.
  Future<Storiest> fetchStoriesTo(String history) async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateHash(timeStamp);
    final url = _buildUrl(history, '', timeStamp, hash);

    final jsonResponse = await _fetchData(url);
    final general = Storiest.fromJson(jsonResponse);
    return general;
  }

  /// Genera un hash utilizando la marca de tiempo, la clave privada y la clave pública.
  /// El hash se utiliza para autenticar las solicitudes al servicio web de Marvel.
  String generateHash(String timeStamp) {
    final content = timeStamp + privateKey + publicKey;
    final bytes = utf8.encode(content);
    final digest = md5.convert(bytes);
    return digest.toString();
  }

  /// Construye la URL para realizar una solicitud al servicio web de Marvel.
  /// Incluye la ruta, los parámetros de consulta, la marca de tiempo y el hash generados previamente.
  String _buildUrl(String path, String queryParams, String timeStamp, String hash) {
    const baseUrl = 'https://gateway.marvel.com:443/v1/public/';
    final url = '$baseUrl$path?apikey=$publicKey&hash=$hash&ts=$timeStamp$queryParams';
    return url;
  }

  /// Realiza la solicitud HTTP utilizando la URL proporcionada.
  /// Devuelve la respuesta en formato JSON si el estado de la respuesta es 200 (éxito).
  /// De lo contrario, lanza una excepción indicando la incapacidad de realizar la solicitud.
  Future<dynamic> _fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
