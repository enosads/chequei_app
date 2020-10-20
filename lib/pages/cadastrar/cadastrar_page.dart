import 'package:chequei/pages/cadastrar/cadastrar_page_controller.dart';
import 'package:chequei/widgets/app_button.dart';
import 'package:chequei/widgets/app_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastrarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CadastrarPageController(),
      builder: (CadastrarPageController _) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Form(
                key: _.formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blue,
                            ),
                            onPressed: () => Get.back(),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 24, top: 24),
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      AppText(
                        controller: _.tNome,
                        label: 'Nome',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: _.validateNome,
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tEmail,
                        label: 'E-mail',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: _.validateEmail,
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tTelefone,
                        label: 'Telefone',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        telefone: true,
                        validator: _.validateTelefone,
                      ),
                      SizedBox(height: 16),
                      Stack(
                        children: [
                          AppText(
                            controller: TextEditingController(text: '.'),
                            label: 'Data de nascimento',
                            readOnly: true,
                            color: Colors.white,
                          ),
                          Container(
                            width: Get.width,
                            height: 47,
                            color: Colors.transparent,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            child: DateTimePicker(
                              locale: Locale('pt', 'BR'),
                              type: DateTimePickerType.date,
                              initialValue:
                                  DateTime(DateTime.now().year - 18).toString(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(DateTime.now().year - 18),
                              onChanged: (val) =>
                                  _.dataNascimento.value = DateTime.parse(val),
                              dateMask: 'dd/MM/yyyy',
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tCpf,
                        label: 'CPF',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        cpf: true,
                        validator: _.validateCpf,
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tUsername,
                        label: 'Username',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: _.validateUsername,
                      ),
                      SizedBox(height: 16),
                      Form(
                        key: _.formKeySenha,
                        child: Column(
                          children: [
                            Obx(() => Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    AppText(
                                      controller: _.tSenha,
                                      label: 'Senha',
                                      onChanged: (String value) {
                                        _.formKeySenha.currentState.validate();
                                      },
                                      password: _.obscureTextSenha.value,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: _.validateSenha,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      child: IconButton(
                                        icon: Icon(_.obscureTextSenha.value
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: _.onPressedObscureSenha,
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            Obx(
                              () => Stack(
                                alignment: _.obscureTextRepetirSenha.value
                                    ? Alignment.topRight
                                    : Alignment.centerRight,
                                children: [
                                  AppText(
                                    controller: _.tConfirmarSenha,
                                    label: 'Confirmar senha',
                                    password: _.obscureTextRepetirSenha.value,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    onFieldSubmitted: (v) {
                                      _.onClickCadastrar();
                                      Get.focusScope.unfocus();
                                    },
                                    onChanged: (String value) {
                                      _.formKeySenha.currentState.validate();
                                    },
                                    validator: _.validateRepetirSenha,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    child: IconButton(
                                      icon: Icon(_.obscureTextRepetirSenha.value
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: _.onPressedObscureRepetirSenha,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      AppButton(
                        'CADASTRAR',
                        color: Colors.blue,
                        onPressed: () => _.onClickCadastrar(),
                        showProgress: false,
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Obx(
                () => _.loading.value
                    ? Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              )
            ],
          ),
        );
      },
    );
  }
}
