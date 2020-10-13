import 'package:chequei/pages/login/login_page_controller.dart';
import 'package:chequei/widgets/app_button.dart';
import 'package:chequei/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginPageController(),
      builder: (LoginPageController _) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Form(
                key: _.formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 24.0),
                          Hero(
                            tag: 'hero',
                            child: CircleAvatar(
                              radius: 120.0,
//                              child: Image.asset(
//                                'assets/images/logo.png',
//                              ),
                              child: Icon(
                                Icons.event,
                                size: 120,
                              ),
                            ),
                          ),
                          SizedBox(height: 24.0),
                          AppText(
                            hint: 'Nome de usuário',
                            controller: _.tLogin,
                            validator: _.validateLogin,
                            nextFocus: _.focusSenha,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 16.0),
                          Obx(
                            () => Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                AppText(
                                  hint: 'Senha',
                                  controller: _.tSenha,
                                  password: _.obscureTextSenha.value,
                                  validator: _.validateSenha,
                                  focusNode: _.focusSenha,
                                  onFieldSubmitted: (next) => _.onClickLogin(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: IconButton(
                                    icon: Icon(
                                      _.obscureTextSenha.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.blue,
                                    ),
                                    onPressed: _.onPressedObscureSenha,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 24.0),
                          AppButton(
                            'ENTRAR',
                            color: Colors.blue,
                            onPressed: () => _.onClickLogin(),
                            showProgress: false,
                            textColor: Colors.white,
                          ),
                          SizedBox(height: 8.0),
                          AppButton(
                            'CADASTRAR',
                            onPressed: () => _.onClickCadastrar(),
                            showProgress: false,
                            textColor: Colors.grey,
                          ),
                          SizedBox(height: 24.0),
                        ],
                      ),
                    ),
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
