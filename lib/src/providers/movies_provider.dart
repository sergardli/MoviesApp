
import 'package:http/http.dart' as http;
import 'package:movies/src/models/actor.dart';

import 'dart:convert';
import 'dart:async';

import 'package:movies/src/models/movie.dart';


class MoviesProvider {

  String _apikey     = '6f89470b187d067ed6dfe68c32cb94eb';
  String _url        = 'api.themoviedb.org';
  String _language   = 'es-ES';

  int _popularPage   = 0;
  bool _loadingData  = false;

  List<Movie> _populars = new List();


  final _popularsStreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;
  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;


  /**
   * Cerrar los Streams
   */
  void disposeStream() {
    _popularsStreamController.close();
  }


  /**
   * Procesa la respuesta de la llamada HTTP
   */
  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }


  /**
   * Obtiene las películas que se encuentran en el cine actualmente
   */
  Future<List<Movie>> getOnTheaters() async {
    
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apikey,
      'language' : _language,

    });

    return await _processResponse(url);
  }


  /**
   * Obtiene las películas más populares
   */
  Future<List<Movie>> getPopulars() async {
  
    if (_loadingData) return[];

    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
    'api_key'  : _apikey,
    'language' : _language,
    'page'     : _popularPage.toString()
  });

    final resp = await _processResponse(url);

    _populars.addAll(resp);
    popularsSink(_populars);

    _loadingData = false;

    return resp;
  }


  /**
   * Obtiene el cast de la película
   */
  Future<List<Actor>> getCast( String movieId ) async {

    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key'  : _apikey,
      'language' : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final casting = new Cast.fromJsonList(decodedData['cast']);

    return casting.actors;
  }


  /**
   * Obtiene las películas que se encuentran en el cine actualmente
   */
  Future<List<Movie>> searchMovie( String query ) async {
    
    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query
    });

    return await _processResponse(url);
  }

}