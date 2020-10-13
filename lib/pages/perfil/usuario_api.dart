import 'dart:convert';

import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/utils/http_helper.dart' as http;
import 'package:chequei/utils/singleton.dart';

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

  static Future<ApiResponse<Usuario>> cadastrar(
      String nome,
      String cpf,
      String telefone,
      String email,
      String username,
      String password,
      String dataNascimento) async {
    try {
      var url = Factory.internal().getUrl() + 'usuario/create/';
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      final Map params = {
        "nome": nome,
        "email": email,
        "telefone": telefone,
        "cpf": cpf,
        'data_nascimento': dataNascimento,
        "user": {"username": username, "password": password}
      };

      String s = json.encode(params);
      print(s);
      var response = await http.post(url, body: s, headers: headers);
      print('POST >> $url  Status: ${response.statusCode}');
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return ApiResponse.ok();
      } else {
        Map mapResponse = json.decode(utf8.decode(response.bodyBytes));
        final usuario = Usuario.fromMap(mapResponse['detail'], error: true);
        return ApiResponse.error(
            msg: 'Algumas campos possuem erros.', result: usuario);
      }
    } catch (error, exception) {
      print('Erro ao cadastrar usuario: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível efetuar o cadastro');
    }
  }
}
