import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/pages/enderecos/endereco_api.dart';
import 'package:get/get.dart';

class EnderecosPageController extends GetxController {
  static EnderecosPageController get to => Get.find();

  List<Endereco> enderecos;

  @override
  void onInit() {
    fetchEnderecos();
  }

  fetchEnderecos() async {
    enderecos = null;
    var response = await EnderecoApi.getEnderecos();
    if (response.ok) {
      enderecos = response.result;
    } else {
      enderecos = [];
    }
    update();
    return enderecos;
  }
}
