import 'package:chequei/pages/cadastrar/cadastrar_page.dart';
import 'package:chequei/pages/home_page/home_page.dart';
import 'package:chequei/pages/login/login_api.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:chequei/utils/prefs.dart';
import 'package:chequei/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  LoginPageController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    lastLogin();
  }

  var formKey = GlobalKey<FormState>();
  final tLogin = TextEditingController();
  final tSenha = TextEditingController();
  final focusSenha = FocusNode();
  var loading = false.obs;

  lastLogin() async {
    String login = await Prefs.getString('lastLogin');
    tLogin.text = login;
  }

  String validateLogin(String text) {
    if (text.isEmpty) {
      return 'Digite o nome de usuário';
    }
    if (text.length < 3) {
      return 'A senha precisa ter pelo menos 3 números';
    }
    return null;
  }

  String validateSenha(String text) {
    if (text.isEmpty) {
      return 'Digite a senha';
    }
    return null;
  }

  onClickLogin() async {
    bool formOk = formKey.currentState.validate();
    if (!formOk) {
      return;
    }
    var login = tLogin.text;
    var senha = tSenha.text;

    loading.value = true;
    var response = await LoginApi.login(login, senha);

    loading.value = false;

    if (response.ok) {
      await UsuarioController.to.save(response.result);
      Get.off(HomePage());
    } else {
      AppDialog(
        Text(response.msg),
        onConfirm: () => Get.back(),
      );
    }
  }

  onClickCadastrar() {
    Get.to(CadastrarPage());
  }
}
