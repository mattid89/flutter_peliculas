import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart';

class PeliculasProvider {

  String _apiKey = '256fe8ed1197695aafa914ca83b54720';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _pageNowPlaying = 1;
  int _pagePopulars = 0;
  int _page = 0;

  bool _cargando = false;

  List<Pelicula> _populars = new List();

  final _popularsStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularsSink => _popularsStreamController.sink.add;
  Stream<List<Pelicula>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Pelicula>> _resolveRequest(Uri url) async {
    final response = await get(url);
    final decodedData = json.decode(response.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Uri _uriBuilder(String endpoint) {
    return Uri.https(_url, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': _page.toString()
    });
  }

  Future<List<Pelicula>> getNowPlaying() async {
    _page = _pageNowPlaying;
    final url = _uriBuilder('3/movie/now_playing');
    return await _resolveRequest(url);
  }
  
  Future<List<Pelicula>> getPopulars() async {

    /// como se esta llamando continuamente el get populares cunado el scroll
    /// llega al final de la lista de peliculas, debo evitar que se llamen
    /// muchas veces a la api rest de las peliculas innecesariamente
    if(_cargando) return [];
    _cargando = true;

    _pagePopulars++;
    _page = _pagePopulars;
    final url = _uriBuilder('3/movie/popular');
    final res = await _resolveRequest(url);
    _populars.addAll(res);
    popularsSink(_populars);

    _cargando = false;
    return res;
  }
}