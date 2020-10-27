import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/models/evento_model.dart';
import 'package:chequei/pages/enderecos/editar_endereco_bottom_sheet.dart';
import 'package:chequei/widgets/app_bottom_sheet.dart';
import 'package:chequei/widgets/app_button.dart';
import 'package:chequei/widgets/app_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'novo_evento_bottom_sheet_controller.dart';

class NovoEventoBottomSheet {
  static show({Evento evento}) {
    Get.bottomSheet(
        GetBuilder<NovoEventoBottomSheetController>(
          init: NovoEventoBottomSheetController(evento),
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
                    title: '${evento != null ? 'Editar' : 'Novo'} evento',
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 16, right: 16),
                                  child: AppText(
                                    controller: _.tDescricao,
                                    label: 'Descrição',
                                    keyboardType: TextInputType.text,
                                    validator: _.validateDescricao,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => _.enderecos.isEmpty
                              ? FlatButton(
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      Text('Nenhum endereço cadastrado'),
                                      AppButton(
                                        'Cadastrar endereço',
                                        onPressed: () {
                                          Get.back();
                                          EditarEnderecoBottomSheet.show();
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 16, right: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Expanded(
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  AppText(
                                                    // validator: validator ?? null,
                                                    readOnly: true,
                                                  ),
                                                  Container(
                                                    width: Get.width,
                                                    height: 47,
                                                    color: Colors.transparent,
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                    child: DropdownButton<
                                                        Endereco>(
                                                      items:
                                                          _.enderecos.map((e) {
                                                        return DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            '${e.getPrimeiraParte()} - ${e.bairro.value}, ${e.cidade.value}',
                                                            maxLines: 1,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onTap: () => Get
                                                          .focusScope
                                                          .unfocus(),
                                                      onChanged: (value) {
                                                        if (value !=
                                                                _.enderecoSelecionado
                                                                    .value &&
                                                            _.enderecos
                                                                .contains(
                                                                    value)) {
                                                          _.enderecoSelecionado
                                                              .value = value;
                                                        }
                                                      },
                                                      value: _
                                                          .enderecoSelecionado
                                                          .value,
                                                      isExpanded: true,
                                                      underline: Container(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () =>
                                              EditarEnderecoBottomSheet.show(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 16, right: 16),
                                  child: AppText(
                                    controller: _.tQuantidadeVagas,
                                    label: 'Quantidade de vagas',
                                    keyboardType: TextInputType.number,
                                    validator: _.validateQuantidadeVagas,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Stack(
                            children: [
                              AppText(
                                controller: TextEditingController(text: '.'),
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
                                  type: DateTimePickerType.dateTime,
                                  initialValue: DateTime.now()
                                      .add(Duration(days: 1))
                                      .toString(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  onChanged: (val) =>
                                      _.horario.value = DateTime.parse(val),
                                  dateMask: 'dd/MM/yyyy - HH:mm',
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ],
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
