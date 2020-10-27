import 'package:chequei/models/usuario_model.dart';
import 'package:chequei/pages/enderecos/enderecos_page_controller.dart';
import 'package:chequei/pages/perfil/usuario_api.dart';
import 'package:chequei/pages/splash/splash_page_controller.dart';
import 'package:chequei/utils/prefs.dart';
import 'package:get/get.dart';

class UsuarioController extends GetxController {
  static UsuarioController get to => Get.find();
  Usuario usuario;
  bool splash;

  @override
  void onInit() {
    init();
  }

  void init() async {
    splash = true;

    if (await getUsuario()) {
      Get.put(EnderecosController());
    }
  }

  getUsuario() async {
    usuario = Usuario();
    String token = await Prefs.getString('usuario.token');
    usuario.token = token != null ? token : '';
    bool r = false;
    if (usuario.token.isNotEmpty) {
      var response = await UsuarioApi.loginToken();
      if (response.ok) {
        usuario = response.result;
        r = true;
      } else {
        usuario = null;
        r = false;
      }
    } else {
      usuario = null;
      r = false;
    }
    if (splash == true) {
      SplashPageController.to.usuarioCarregado.value = true;
      splash = false;
    }

    update();
    return r;
  }

  Future<bool> save(Usuario u) async {
    usuario = u;
    await Prefs.setString('usuario.token', u.token);
    return true;
  }

  Future<bool> clear() async {
    usuario = null;
    await Prefs.setString('usuario.token', '');
    return true;
  }
}
