import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:chequei/pages/splash/splash_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(UsuarioController());
    return GetBuilder<SplashPageController>(
      init: SplashPageController(),
      builder: (_) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Hero(
              tag: 'hero',
              child: CircleAvatar(
                radius: 120.0,
                // child: Image.asset(
                //        'assets/images/logo.png',
                //      ),
                child: Icon(
                  Icons.event,
                  size: 120,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
