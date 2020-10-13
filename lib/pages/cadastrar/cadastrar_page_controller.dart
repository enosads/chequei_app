import 'package:chequei/models/erro_model.dart';
import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/pages/home_page/home_page.dart';
import 'package:chequei/pages/login/login_api.dart';
import 'package:chequei/pages/perfil/usuario_api.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:chequei/utils/api_response.dart';
import 'package:chequei/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastrarPageController extends GetxController {
  TextEditingController tRepetirSenha;
  final formKeySenha = GlobalKey<FormState>(debugLabel: 'senha');
  final cadastrarPressed = false.obs;
  ApiResponse<Usuario> response;
  final obscureTextSenha = true.obs;
  final obscureTextRepetirSenha = true.obs;
  TextEditingController tSenha = TextEditingController(text: 'enosenos');
  TextEditingController tConfirmarSenha =
      TextEditingController(text: 'enosenos');

  CadastrarPageController get to => Get.find();
  TextEditingController tEmail;

  TextEditingController tCpf;

  TextEditingController tNome;

  TextEditingController tUsername;

  TextEditingController tTelefone;

  final dataNascimento = DateTime.now().obs;

  @override
  void onInit() {
    tEmail = TextEditingController(text: 'enosads@gmail.com');
    tCpf = TextEditingController(text: '118.861.574-21');
    tNome = TextEditingController(text: 'Enos Andrade');
    tUsername = TextEditingController(text: 'enosads');
    tTelefone = TextEditingController(text: '(83)99195-5852');
    tSenha = TextEditingController(text: '(83)99195-5852');
    tConfirmarSenha = TextEditingController(text: '(83)99195-5852');
    super.onInit();
  }

  var formKey = GlobalKey<FormState>();
  var loading = false.obs;

  onClickCadastrar() async {
    if (formKeySenha.currentState.validate()) {
      cadastrarPressed.value = true;
      response = await UsuarioApi.cadastrar(
          tNome.text,
          tCpf.text,
          tTelefone.text,
          tEmail.text,
          tUsername.text,
          tSenha.text,
          '${dataNascimento.value.year}-${dataNascimento.value.month}-${dataNascimento.value.day}');

      if (response.ok) {
        var r = await LoginApi.login(tUsername.text, tSenha.text);

        if (r.ok) {
          await UsuarioController.to.save(r.result);
          Get.off(HomePage());
        } else {
          AppDialog(
            Text(r.msg),
            confirmColor: Colors.blue,
            textConfirm: 'ok',
            onConfirm: () => Get.back(),
          ).show();
        }
      } else {
        bool formOk = formKey.currentState.validate();
        if (!formOk) {
          cadastrarPressed.value = false;
          return;
        }
        AppDialog(
          Text(response.msg),
          confirmColor: Colors.blue,
          textConfirm: 'ok',
          onConfirm: () => Get.back(),
        ).show();
      }
      cadastrarPressed.value = false;
    }
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

  String validateCpf(String text) {
    if (response.result.cpf != null) {
      List<Erro> erros = response.result.cpf.erros;
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

  String validateEmail(String text) {
    if (response.result.email != null) {
      List<Erro> erros = response.result.email.erros;
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateUsername(String text) {
    if (response.result.username != null) {
      List<Erro> erros = response.result.username.erros;
      print(erros);
      if (erros != null) {
        return erros[0].message;
      }
    }
    return null;
  }

  String validateSenha(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode está em branco.';
    } else if (value.length < 8) {
      return 'A senha deve ter no mínimo 8 caracteres.';
    } else if (tSenha.text != tConfirmarSenha.text) {
      return 'As senhas são diferentes';
    }
    return null;
  }

  String validateRepetirSenha(String value) {
    if (tConfirmarSenha.text.isEmpty) {
      return 'Este campo não pode está em branco.';
    } else if (tSenha.text != tConfirmarSenha.text) {
      return 'As senhas são diferentes';
    }
    return null;
  }

  void onPressedObscureSenha() {
    obscureTextSenha.value = !obscureTextSenha.value;
  }

  void onPressedObscureRepetirSenha() {
    obscureTextRepetirSenha.value = !obscureTextRepetirSenha.value;
  }
}
