import 'dart:math';

import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/models/erro_model.dart';
import 'package:chequei/pages/enderecos/endereco_api.dart';
import 'package:chequei/pages/enderecos/enderecos_page_controller.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarEnderecoBottomSheetController extends GetxController {
  Endereco endereco;

  List<String> dropEstados;
  final estadoSelecionado = 'AC'.obs;

  EditarEnderecoBottomSheetController(this.endereco);

  TextEditingController tRua;
  TextEditingController tNumero;
  TextEditingController tComplemento;
  TextEditingController tCep;
  TextEditingController tBairro;
  TextEditingController tCidade;
  ApiResponse<Endereco> response;
  final formKey = GlobalKey<FormState>();
  FocusNode focusNumero;
  FocusNode focusComplemento;
  FocusNode focusBairro;
  FocusNode focusEstado;
  FocusNode focusRua;
  FocusNode focusCep;

  final salvarPressed = false.obs;

  static EditarEnderecoBottomSheetController get to => Get.find();

  @override
  void onInit() {
    focusComplemento = FocusNode();
    focusNumero = FocusNode();
    focusBairro = FocusNode();
    focusEstado = FocusNode();
    focusCep = FocusNode();
    focusRua = FocusNode();
    resetText();
  }

  Future<void> resetText() async {
    tRua = TextEditingController(
      text: endereco != null ? endereco.rua.value : '',
    );
    tNumero = TextEditingController(
        text: endereco != null ? endereco.numero.value : '');
    tComplemento = TextEditingController(
        text: endereco != null ? endereco.complemento.value : '');
    tCep =
        TextEditingController(text: endereco != null ? endereco.cep.value : '');
    tBairro = TextEditingController(
        text: endereco != null ? endereco.bairro.value : '');
    tCidade = TextEditingController(
        text: endereco != null ? endereco.cidade.value : '');

    dropEstados = [];
    if (estadoSelecionado.value == 'Estado') {
      dropEstados.add('Estado');
    }
    dropEstados.addAll(Endereco.getEstados());
    if (endereco != null) {
      estadoSelecionado.value = endereco.estado.value;
    }
    update();
    return;
  }

  onClickSalvar() async {
    salvarPressed.value = true;

    if (endereco != null) {
      response = await EnderecoApi.update(
          endereco.id,
          tRua.text,
          tNumero.text,
          tBairro.text,
          tCidade.text,
          estadoSelecionado.value,
          tCep.text,
          tComplemento.text);
    } else {
      response = await EnderecoApi.create(tRua.text, tNumero.text, tBairro.text,
          tCidade.text, estadoSelecionado.value, tCep.text, tComplemento.text);
    }

    if (response.ok) {
      print('ok');
      EnderecosPageController.to.fetchEnderecos();
      Get.back();
      AppDialog(
        Text('Endereço salvo com sucesso.'),
        onCancel: () => Get.back(),
        textCancel: "Ok",
      );
    } else {
      print('error');
      formKey.currentState.validate();
    }
    salvarPressed.value = false;
  }

  String validateRua(String text) {
    if (response.result.rua != null) {
      List<Erro> erros = response.result.rua.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateNumero(String text) {
    if (response.result.numero != null) {
      List<Erro> erros = response.result.numero.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateBairro(String text) {
    if (response.result.bairro != null) {
      List<Erro> erros = response.result.bairro.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateComplemento(String text) {
    if (response.result.complemento != null) {
      List<Erro> erros = response.result.complemento.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateCidade(String text) {
    if (response.result.cidade != null) {
      List<Erro> erros = response.result.cidade.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateCep(String text) {
    if (response.result.cep != null) {
      List<Erro> erros = response.result.cep.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }
}
