import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/pages/enderecos/editar_endereco_bottom_sheet_controller.dart';
import 'package:chequei/widgets/app_bottom_sheet.dart';
import 'package:chequei/widgets/app_button.dart';
import 'package:chequei/widgets/app_text.dart';
import 'package:chequei/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarEnderecoBottomSheet {
  static show({Endereco endereco}) {
    Get.bottomSheet(
        GetBuilder<EditarEnderecoBottomSheetController>(
          init: EditarEnderecoBottomSheetController(endereco),
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
                    title:
                        '${endereco != null ? 'Editar' : 'Adicionar'} endereço',
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 8, right: 4),
                                  child: AppText(
                                    controller: _.tCidade,
                                    label: 'Cidade',
                                    nextFocus: _.focusEstado,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    validator: _.validateRua,
                                  ),
                                ),
                              ),
                              Obx(()=>Expanded(
                                flex: 4,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 8, top: 8, bottom: 8),
                                  child: Stack(
                                    children: [
                                      AppText(
                                        readOnly: true,
                                      ),
                                      Container(
                                        width: Get.width,
                                        height: 47,
                                        color: Colors.transparent,
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: DropdownButton<String>(
                                          items: _.dropEstados.map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            );
                                          }).toList(),
                                          onTap: () => Get.focusScope.unfocus(),
                                          onChanged: (value) {
                                            if (value !=
                                                _.estadoSelecionado.value &&
                                                _.dropEstados.contains(value)) {
                                              _.estadoSelecionado.value = value;
                                            }
                                          },
                                          value: _.estadoSelecionado.value,
                                          isExpanded: true,
                                          underline: Container(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 8, right: 4),
                                  child: AppText(
                                    controller: _.tRua,
                                    label: 'Rua',
                                    focusNode: _.focusRua,
                                    nextFocus: _.focusNumero,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    validator: _.validateRua,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 8, top: 8, bottom: 8),
                                  child: AppText(
                                    controller: _.tNumero,
                                    label: 'Número',
                                    nextFocus: _.focusBairro,
                                    focusNode: _.focusNumero,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    validator: _.validateNumero,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: AppText(
                            controller: _.tBairro,
                            label: 'Bairro',
                            focusNode: _.focusBairro,
                            nextFocus: _.focusCep,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            validator: _.validateBairro,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: AppText(
                              controller: _.tCep,
                              label: 'Cep',
                              focusNode: _.focusCep,
                              nextFocus: _.focusComplemento,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              validator: _.validateCep,
                              cep: true),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: AppText(
                            controller: _.tComplemento,
                            label: 'Complemento',
                            focusNode: _.focusComplemento,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            validator: _.validateComplemento,
                            onFieldSubmitted: _.salvarPressed.value
                                ? null
                                : (v) => _.onClickSalvar(),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Obx(
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
