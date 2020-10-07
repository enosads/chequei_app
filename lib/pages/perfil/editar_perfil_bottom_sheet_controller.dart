import 'package:chequei/models/erro_model.dart';
import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/pages/perfil/usuario_api.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarPerfilBottomSheetController extends GetxController {
  TextEditingController tNome;
  TextEditingController tEmail;
  TextEditingController tTelefone;
  ApiResponse<Usuario> response;
  final formKey = GlobalKey<FormState>();
  FocusNode focusEmail;
  FocusNode focusTelefone;
  final salvarPressed = false.obs;

  final dataNascimento = UsuarioController.to.usuario.dataNascimento.obs;

  static EditarPerfilBottomSheetController get to => Get.find();

  @override
  void onInit() {
    focusTelefone = FocusNode();
    focusEmail = FocusNode();
    resetTextPerfil();
  }

  String validateNome(String text) {
    if (response.result.nome != null) {
      List<Erro> erros = response.result.nome.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateEmail(String text) {
    if (response.result.email != null) {
      List<Erro> erros = response.result.email.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateTelefone(String text) {
    if (response.result.telefone != null) {
      List<Erro> erros = response.result.telefone.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateDataNascimento(String text) {
    if (response.result.dataNascimento != null) {
      List<Erro> erros = response.result.telefone.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  resetTextPerfil() {
    tNome = TextEditingController(
      text: UsuarioController.to.usuario.nome.value,
    );
    tEmail =
        TextEditingController(text: UsuarioController.to.usuario.email.value);
    tTelefone = TextEditingController(
        text: UsuarioController.to.usuario.telefone.value);
  }

  onClickSalvar() async {
    salvarPressed.value = true;
    String date =
        "${dataNascimento.value.value.year}-${dataNascimento.value.value.month}-${dataNascimento.value.value.day}";
    response =
        await UsuarioApi.update(tNome.text, tEmail.text, tTelefone.text, date);
    if (response.ok) {
      UsuarioController.to.getUsuario();
      Get.back();
      AppDialog(
        Text('Perfil salvo com sucesso.'),
        onCancel: () => Get.back(),
        textCancel: "Ok",
      );
    } else {
      formKey.currentState.validate();
    }
    salvarPressed.value = false;
  }
}
