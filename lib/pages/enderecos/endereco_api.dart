import 'dart:convert';

import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/utils/http_helper.dart' as http;
import 'package:chequei/utils/singleton.dart';

class EnderecoApi {
  static Future<ApiResponse<List<Endereco>>> getEnderecos() async {
    try {
      var url;
      url = Factory.internal().getUrl() + 'enderecos/';
      var response = await http.get(url);
      print('GET >> $url  Status: ${response.statusCode}');

      final list = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        List<Endereco> enderecos =
            list.map<Endereco>((map) => Endereco.fromMap(map)).toList();

        return ApiResponse.ok(result: enderecos);
      }
      return ApiResponse.error(msg: response.body);
    } catch (error, exception) {
      print('Erro ao buscar enderecos: $error > $exception');
      return ApiResponse.error(msg: 'Não foi buscar os enderecos');
    }
  }

  static Future<ApiResponse<Endereco>> update(
      int id,
      String rua,
      String numero,
      String bairro,
      String cidade,
      String estado,
      String cep,
      String complemento) async {
    try {
      var url = Factory.internal().getUrl() + '$id/endereco/';

      final Map params = {
        "rua": rua,
        "numero": numero,
        "bairro": bairro,
        "cidade": cidade,
        "estado": estado,
        "complemento": complemento,
        "cep": cep,
      };

      String s = json.encode(params);
      var response = await http.patch(url, body: s);
      print('PATCH >> $url  Status: ${response.statusCode}');

      Map mapResponse = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final endereco = Endereco.fromMap(mapResponse);

        return ApiResponse.ok(result: endereco);
      } else {
        final endereco = Endereco.fromMap(mapResponse['detail'], error: true);

        return ApiResponse.error(
            msg: 'Algumas campos possuem erros.', result: endereco);
      }
    } catch (error, exception) {
      print('Erro ao atualizar endereço: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível atualizar o endereço');
    }
  }

  static Future<ApiResponse<Endereco>> create(
      String rua,
      String numero,
      String bairro,
      String cidade,
      String estado,
      String cep,
      String complemento) async {
    try {
      var url = Factory.internal().getUrl() + 'endereco/';

      final Map params = {
        "rua": rua,
        "numero": numero,
        "bairro": bairro,
        "cidade": cidade,
        "estado": estado,
        "complemento": complemento,
        "cep": cep,
        "usuario": UsuarioController.to.usuario.id
      };

      String s = json.encode(params);
      print(s);
      var response = await http.post(url, body: s);
      print('POST >> $url  Status: ${response.statusCode}');

      Map mapResponse = json.decode(utf8.decode(response.bodyBytes));
      print(mapResponse);

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        final endereco = Endereco.fromMap(mapResponse);

        return ApiResponse.ok(result: endereco);
      } else {
        final endereco = Endereco.fromMap(mapResponse['detail'], error: true);

        return ApiResponse.error(
            msg: 'Algumas campos possuem erros.', result: endereco);
      }
    } catch (error, exception) {
      print('Erro ao adicionar endereço: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possível adicionar o endereço');
    }
  }

  static Future<ApiResponse<void>> deletarEndereco(int id) async {
    try {
      var url;
      url = Factory.internal().getUrl() + '$id/endereco/';
      var response = await http.delete(url);
      print('DELETE >> $url  Status: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return ApiResponse.ok(result: null);
      }
      final map = json.decode(utf8.decode(response.bodyBytes));
      return ApiResponse.error(msg: map['detail']);
    } catch (error, exception) {
      print('Erro ao excluir endereco: $error > $exception');
      return ApiResponse.error(msg: 'Não foi possivel excluir o endereco');
    }
  }
}
