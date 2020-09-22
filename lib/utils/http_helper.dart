import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:http/http.dart' as http;

Future<http.Response> get(String url) async {
  final headers = await _headers();
  var response = await http.get(url, headers: headers);
  return response;
}

Future<http.Response> post(String url, {body}) async {
  final headers = await _headers();
  var response = await http.post(url, body: body, headers: headers);
  return response;
}

Future<http.Response> put(String url, {body}) async {
  final headers = await _headers();
  var response = await http.put(url, body: body, headers: headers);
  return response;
}

Future<http.Response> patch(String url, {body}) async {
  final headers = await _headers();
  var response = await http.patch(url, body: body, headers: headers);
  return response;
}

Future<http.Response> delete(String url) async {
  final headers = await _headers();
  var response = await http.delete(url, headers: headers);
  return response;
}

Future<Map<String, String>> _headers() async {
  Usuario usuario = UsuarioController.to.usuario;

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Token ${usuario.token}"
  };
  return headers;
}
