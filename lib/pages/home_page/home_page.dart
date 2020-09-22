import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Usuario usuario = UsuarioController.to.usuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Logado com ${usuario.nome}'),
    ));
  }
}
