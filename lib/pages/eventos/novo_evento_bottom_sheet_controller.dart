import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/models/erro_model.dart';
import 'package:chequei/models/evento_model.dart';
import 'package:chequei/pages/enderecos/enderecos_page_controller.dart';
import 'package:chequei/pages/eventos/eventos_api.dart';
import 'package:chequei/pages/eventos/eventos_controller.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NovoEventoBottomSheetController extends GetxController {
  Evento evento;

  final enderecoSelecionado = Endereco(id: 1).obs;

  List<Endereco> enderecos = [];
  final enderecosEmpty = true.obs;

  final horario = DateTime.now().add(Duration(days: 1)).obs;

  NovoEventoBottomSheetController(this.evento);

  TextEditingController tDescricao = TextEditingController();
  TextEditingController tQuantidadeVagas = TextEditingController(text: '0');
  ApiResponse<Evento> response;
  final formKey = GlobalKey<FormState>();

  final salvarPressed = false.obs;

  static NovoEventoBottomSheetController get to => Get.find();

  Future<void> fetchEnderecos({Endereco selecionarEndereco}) {
    enderecos = EnderecosController.to.enderecos;
    if (enderecos.length == 0) {
      enderecosEmpty.value = true;
    } else {
      enderecoSelecionado.value = enderecos[enderecos.length - 1];
      enderecosEmpty.value = false;
    }
  }

  @override
  void onInit() {
    fetchEnderecos();
  }

  onClickSalvar() async {
    salvarPressed.value = true;
    print('onClickSalvar');
    if (evento != null) {
      // response = await EventosApi.update(
      //     endereco.id,
      //     tRua.text,
      //     tNumero.text,
      //     tBairro.text,
      //     tCidade.text,
      //     estadoSelecionado.value,
      //     tCep.text,
      //     tComplemento.text);
    } else {
      print('create');
      response = await EventosApi.create(
          tDescricao.text,
          enderecoSelecionado.value,
          horario.value,
          tQuantidadeVagas.text.isNum
              ? int.parse(tQuantidadeVagas.text)
              : null);
    }
    if (response.ok) {
      EventosController.to.fetchEventos();
      Get.back();
      AppDialog(
        Text('Evento salvo com sucesso.'),
        onCancel: () => Get.back(),
        textCancel: "Ok",
      );
    } else {
      formKey.currentState.validate();
    }
    salvarPressed.value = false;
  }

  String validateDescricao(String text) {
    print('validateDescricao');
    print(response.result);
    if (response.result.descricao != null) {
      List<Erro> erros = response.result.descricao.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateQuantidadeVagas(String text) {
    if (response.result.quantidadeDeVagas != null) {
      List<Erro> erros = response.result.quantidadeDeVagas.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }
}
