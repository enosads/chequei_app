import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/pages/enderecos/editar_endereco_bottom_sheet.dart';
import 'package:chequei/pages/enderecos/enderecos_listview.dart';
import 'package:chequei/pages/enderecos/enderecos_page_controller.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnderecosPage extends StatelessWidget {
  Usuario usuario = UsuarioController.to.usuario;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnderecosPageController>(
      init: EnderecosPageController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Meus endereços'),
            centerTitle: true,
          ),
          body: _body(_),
          floatingActionButton: FloatingActionButton(
            heroTag: 'add_endereco_fab',
            onPressed: () {
              EditarEnderecoBottomSheet.show();
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  _body(EnderecosPageController _) {
    return RefreshIndicator(
      onRefresh: () => _.fetchEnderecos(),
      child: _.enderecos == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _.enderecos.isEmpty
              ? GestureDetector(
                  onTap: () => _.fetchEnderecos(),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Você ainda não tem enderecos cadastrados.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Toque no "+" abaixo para cadastrar um.',
                        ),
                      ],
                    ),
                  ),
                )
              : EnderecosListView(),
    );
  }
}
