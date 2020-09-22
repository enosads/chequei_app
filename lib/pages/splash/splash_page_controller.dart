import 'package:chequei/pages/home_page/home_page.dart';
import 'package:chequei/pages/login/login_page.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  static SplashPageController get to => Get.find();
  final usuarioCarregado = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(usuarioCarregado, (usuarioCarregado) {
      print(usuarioCarregado);
      if (usuarioCarregado) {
        if (UsuarioController.to.usuario != null) {
          Get.off(HomePage());
        } else {
          Get.off(LoginPage());
        }
      }
    });
  }
}
