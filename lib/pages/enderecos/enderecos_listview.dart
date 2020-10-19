import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/pages/enderecos/editar_endereco_bottom_sheet.dart';
import 'package:chequei/pages/enderecos/endereco_api.dart';
import 'package:chequei/pages/enderecos/enderecos_page_controller.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/widgets/app_dialog.dart';
import 'package:chequei/widgets/card_endereco.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnderecosListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        Endereco endereco = EnderecosPageController.to.enderecos[index];
        return Container(
          margin: EdgeInsets.only(
              top: 8,
              bottom: EnderecosPageController.to.enderecos.length - 1 == index
                  ? 96
                  : 4,
              right: 8,
              left: 8),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CardEndereco(endereco),
              Container(
                padding: EdgeInsets.all(4),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Editar') {
                      EditarEnderecoBottomSheet.show(endereco: endereco);
                    } else if (value == 'Deletar') {
                      _onClickDeletarEndereco(endereco);
                    }
                  },
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                  tooltip: 'Mais opções',
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'Editar',
                      child: Text('Editar'),
                    ),
                    PopupMenuItem(
                      value: 'Deletar',
                      child: Text('Deletar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: EnderecosPageController.to.enderecos.length,
    );
  }

  void _onClickDeletarEndereco(Endereco endereco) {
    AppDialog(
            Text(
              'Deseja realmente deletar este endereço?',
            ), onConfirm: () async {
      ApiResponse<void> response =
          await EnderecoApi.deletarEndereco(endereco.id);
      if (response.ok) {
        Get.back();
        AppDialog(Text('Endereço deletado com sucesso.'), onConfirm: () {
          Get.back();
          EnderecosPageController.to.fetchEnderecos();
        }, textConfirm: 'Ok')
            .show();
      } else {
        Get.back();
        AppDialog(
                Text('Não foi possível deletar esse endereço: ${response.msg}'),
                onConfirm: () => Get.back(),
                textConfirm: 'Ok')
            .show();
      }
    }, textCancel: 'Cancelar')
        .show();
  }
}
