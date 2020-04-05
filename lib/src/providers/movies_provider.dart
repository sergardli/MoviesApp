import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:movies/src/models/movie.dart';


class MoviesProvider {

  String _apikey     = '6f89470b187d067ed6dfe68c32cb94eb';
  String _url        = 'api.themoviedb.org';
  String _language   = 'es-ES';


  Future<List<Movie>> getOnTheaters() async {
    
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apikey,
      'language' : _language,

    });

    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}