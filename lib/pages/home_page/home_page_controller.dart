import 'package:chequei/pages/enderecos/enderecos_page_controller.dart';
import 'package:chequei/pages/eventos/eventos_page.dart';
import 'package:chequei/pages/perfil/perfil_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();

  final currentIndex = 0.obs;
  List<Widget> pages;

  @override
  void onInit() {
    Get.put(EnderecosController());
    pages = [
      EventosPage(),
      PerfilPage(),
    ];
  }
}
