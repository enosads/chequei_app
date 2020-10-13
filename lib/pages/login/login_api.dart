import 'dart:convert';

import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/utils/singleton.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      var url = Factory.internal().getUrl() + 'login/';

      final Map params = {
        "username": login,
        "password": senha,
        "tipo": 'PARCEIRO',
      };

      String s = json.encode(params);
      print(url);
      var response = await http.post(url, headers: headers, body: s);
      print('POST >> $url  Status: ${response.statusCode}');

      Map mapResponse = json.decode(utf8.decode(response.bodyBytes));
      print(mapResponse);

      if (response.statusCode == 200) {
        final user = Usuario.fromMap(mapResponse);

        return ApiResponse.ok(result: user);
      }
      return ApiResponse.error(msg: mapResponse['error']);
    } catch (error, exception) {
      print('Erro no login: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível fazer o login');
    }
  }
}
