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
                        nextFocus: _.focusEmail,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tEmail,
                        label: 'E-mail',
                        nextFocus: _.focusTelefone,
                        focusNode: _.focusEmail,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tTelefone,
                        label: 'Telefone',
                        focusNode: _.focusTelefone,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        telefone: true,
                      ),
                      SizedBox(height: 16),
                      Stack(
                        children: [
                          AppText(
                            controller: TextEditingController(text: '.'),
                            label: 'Data de nascimento',
                            readOnly: true,
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
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tUsername,
                        label: 'Username',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tSenha,
                        label: 'Senha',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        password: true,
                      ),
                      SizedBox(height: 16),
                      AppText(
                        controller: _.tRepetirSenha,
                        label: 'Repetir senha',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        password: true,
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
