import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastrarPageController extends GetxController {
  TextEditingController tRepetirSenha;

  TextEditingController tSenha;

  CadastrarPageController get to => Get.find();
  TextEditingController tEmail;

  TextEditingController tCpf;
  TextEditingController tNome;
  TextEditingController tUsername;
  TextEditingController tTelefone;
  FocusNode focusEmail;
  FocusNode focusTelefone;
  final dataNascimento = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
  }

  var formKey = GlobalKey<FormState>();
  var loading = false.obs;

  String validateSenha(String text) {
    if (text.isEmpty) {
      return 'Digite a senha';
    }
    return null;
  }

  onClickLogin() async {
    // bool formOk = formKey.currentState.validate();
    // if (!formOk) {
    //   return;
    // }
    //
    // loading.value = true;
    //
    // loading.value = false;
    //
    // if (response.ok) {
    //   await UsuarioController.to.save(response.result);
    //   Get.off(HomePage());
    // } else {
    //   AppDialog(
    //     Text(response.msg),
    //     onConfirm: () => Get.back(),
    //   );
    // }
  }

  onClickCadastrar() {}
}
