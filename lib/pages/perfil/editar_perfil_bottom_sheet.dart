import 'package:chequei/pages/perfil/editar_perfil_bottom_sheet_controller.dart';
import 'package:chequei/widgets/app_bottom_sheet.dart';
import 'package:chequei/widgets/app_button.dart';
import 'package:chequei/widgets/app_text.dart';
import 'package:chequei/widgets/tile.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarPerfilBottomSheet {
  static show() {
    Get.bottomSheet(
        GetBuilder<EditarPerfilBottomSheetController>(
          init: EditarPerfilBottomSheetController(),
          builder: (_) {
            return Form(
              key: _.formKey,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Obx(
                    () => _.salvarPressed.value
                        ? Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(color: Colors.transparent)),
                  ),
                  AppBottomSheet(
                    title: 'Editar Perfil',
                    child: Column(
                      children: [
                        Tile(
                          title: AppText(
                            controller: _.tNome,
                            label: 'Nome',
                            nextFocus: _.focusEmail,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            validator: _.validateNome,
                          ),
                        ),
                        Tile(
                          title: AppText(
                            controller: _.tEmail,
                            label: 'E-mail',
                            nextFocus: _.focusTelefone,
                            focusNode: _.focusEmail,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: _.validateEmail,
                          ),
                        ),
                        Tile(
                          title: AppText(
                            controller: _.tTelefone,
                            label: 'Telefone',
                            focusNode: _.focusTelefone,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            telefone: true,
                            validator: _.validateTelefone,
                            onFieldSubmitted: _.salvarPressed.value
                                ? null
                                : (v) => _.onClickSalvar(),
                          ),
                        ),
                        Tile(
                          title: Stack(
                            children: [
                              AppText(
                                // controller: TextEditingController(text: '.'),
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
                                      _.dataNascimento.value.value.toString(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(DateTime.now().year),
                                  onChanged: (val) => _.dataNascimento.value
                                      .value = DateTime.parse(val),
                                  dateMask: 'dd/MM/yyyy',
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tile(
                          title: Obx(
                            () => AppButton(
                              'Salvar ',
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: _.salvarPressed.value
                                  ? null
                                  : () => _.onClickSalvar(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent);
  }
}
