import 'package:http/http.dart' as http;
import 'package:movies/src/models/actor.dart';

import 'dart:convert';
import 'dart:async';

import 'package:movies/src/models/movie.dart';


class ActorsProvider {

  String _apikey     = '6f89470b187d067ed6dfe68c32cb94eb';
  String _url        = 'api.themoviedb.org';
  String _language   = 'es-ES';


  /**
   * Procesa la respuesta de la llamada HTTP
   */
  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['cast']);

    return movies.items;
  }


  /**
   * Obtiene las películas que se encuentran en el cine actualmente
   */
  Future<List<Movie>> getMovies(Actor actor) async {
    
    final url = Uri.https(_url, '3/person/${actor.id}/movie_credits', {
      'api_key'  : _apikey,
      'language' : _language,
    });

    return await _processResponse(url);
  }

}