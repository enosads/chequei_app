import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/utils/http_helper.dart' as http;
import 'package:chequei/utils/singleton.dart';
import 'dart:convert';

class UsuarioApi {
  static Future<ApiResponse<Usuario>> loginToken() async {
    try {
      var url = Factory.internal().getUrl() + 'login-token/';


      var response = await http.get(url,);
      print('GET >> $url  Status: ${response.statusCode}');

      Map mapResponse = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final user = Usuario.fromMap(mapResponse);

        return ApiResponse.ok(result: user);
      }
      return ApiResponse.error(msg: mapResponse['erro']);
    } catch (error, exception) {
      print('Erro no login: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível fazer o login');
    }
  }
}
