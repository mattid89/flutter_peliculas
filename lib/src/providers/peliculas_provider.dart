import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart';

class PeliculasProvider {

  String _apiKey = '256fe8ed1197695aafa914ca83b54720';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> _resolveRequest(Uri url) async {
    final response = await get(url);
    final decodedData = json.decode(response.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Uri _uriBuilder(String endpoint) {
    return Uri.https(_url, endpoint, {
      'api_key': _apiKey,
      'language': _language
    });
  }

  Future<List<Pelicula>> getNowPlaying() async {
    final url = _uriBuilder('3/movie/now_playing');
    return _resolveRequest(url);
  }
  
  Future<List<Pelicula>> getPopulars() async {
    final url = _uriBuilder('3/movie/popular');
    return _resolveRequest(url);
  }
}