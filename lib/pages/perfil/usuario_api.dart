import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/utils/http_helper.dart' as http;
import 'package:chequei/utils/singleton.dart';
import 'dart:convert';

class UsuarioApi {
  static Future<ApiResponse<Usuario>> loginToken() async {
    try {
      var url = Factory.internal().getUrl() + 'login-token/';

      var response = await http.get(
        url,
      );
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

  static update(
      String nome, String email, String telefone, String dataNascimento) async {
    try {
      var url = Factory.internal().getUrl() + 'usuario/editar/';

      final Map params = {
        "nome": nome,
        "email": email,
        "telefone": telefone,
        "data_nascimento": dataNascimento,
      };

      String s = json.encode(params);
      print(s);
      var response = await http.patch(url, body: s);
      print(response.body);
      print('PATCH >> $url  Status: ${response.statusCode}');

      Map mapResponse = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final usuario = Usuario.fromMap(mapResponse);

        return ApiResponse.ok(result: usuario);
      } else {
        final usuario = Usuario.fromMap(mapResponse, error: true);

        return ApiResponse.error(
            msg: 'Algumas campos possuem erros.', result: usuario);
      }
    } catch (error, exception) {
      print('Erro ao editar perfil: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível atualizar o perfil');
    }
  }
}
