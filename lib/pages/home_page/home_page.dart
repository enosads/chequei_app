import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/pages/home_page/home_page_controller.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:chequei/widgets/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  Usuario usuario = UsuarioController.to.usuario;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      builder: (_) {
        return Scaffold(
          body: Obx(
            () => IndexedStack(index: _.currentIndex.value, children: _.pages),
          ),
          bottomNavigationBar: Stack(
            children: [
              Obx(
                () => BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) => _.currentIndex.value = index,
                  currentIndex: _.currentIndex.value,
                  showUnselectedLabels: true,
                  elevation: 16.0,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      title: Text('Eventos'),
                      icon: Icon(Icons.event),
                    ),
                    BottomNavigationBarItem(
                      title: Text('Perfil'),
                      icon: Icon(Icons.account_circle),
                    ),
                  ],
                ),
              ),
              AppDivider(),
            ],
          ),
        );
      },
    );
  }
}
