import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '_apiKey';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.http(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _languaje});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}
