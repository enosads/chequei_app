import 'package:chequei/pages/perfil/perfil_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();

  final currentIndex = 0.obs;
  List<Widget> pages;

  @override
  void onInit() {
    pages = [
      Container(
        color: Colors.red,
      ),
      PerfilPage(),
    ];
  }
}