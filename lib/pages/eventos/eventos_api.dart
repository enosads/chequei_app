import 'dart:convert';

import 'package:chequei/models/evento_model.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/utils/http_helper.dart' as http;
import 'package:chequei/utils/singleton.dart';

class EventosApi {
  static Future<ApiResponse<List<Evento>>> getEventos(
      {bool meus = false}) async {
    try {
      var url;
      if (meus) {
        url = Factory.internal().getUrl() + 'meus_eventos/';
      } else {
        url = Factory.internal().getUrl() + 'todos_os_eventos/';
      }
      var response = await http.get(url);
      print('GET >> $url  Status: ${response.statusCode}');

      final list = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        List<Evento> eventos =
            list.map<Evento>((map) => Evento.fromMap(map)).toList();

        return ApiResponse.ok(result: eventos);
      }
      return ApiResponse.error(msg: response.body);
    } catch (error, exception) {
      print('Erro ao buscar eventos: $error > $exception');
      return ApiResponse.error(msg: 'Não foi buscar as eventos');
    }
  }

}
