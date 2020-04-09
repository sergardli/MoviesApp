import 'package:http/http.dart' as http;
import 'package:movies/src/models/actor.dart';

import 'dart:convert';
import 'dart:async';

import 'package:movies/src/models/person.dart';


class PeopleProvider {

  String _apikey     = '6f89470b187d067ed6dfe68c32cb94eb';
  String _url        = 'api.themoviedb.org';
  String _language   = 'es-ES';


  /**
   * Procesa la respuesta de la llamada HTTP
   */
  Future<People> _processResponse(Uri url) async {
    final resp = await http.get( url );

    final decodedData = json.decode(resp.body);

    final people = new People.fromJsonMap(decodedData);

    return people;
  }


  /**
   * Obtiene las películas que se encuentran en el cine actualmente
   */
  Future<People> getPeople(Actor actor) async {
    
    final url = Uri.https(_url, '3/person/${actor.id}', {
      'api_key'  : _apikey,
      'language' : _language,
    });

    return await _processResponse(url);
  }

}