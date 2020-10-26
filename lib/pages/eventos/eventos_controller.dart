import 'package:chequei/models/evento_model.dart';
import 'package:chequei/pages/eventos/eventos_api.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class EventosController extends GetxController {
  static EventosController get to => Get.find();
  static final String MEUS = 'MEUS';
  static final String INSCRITO = 'INSCRITO';
  static List<Evento> meusEventos;
  static List<Evento> todosEventos;
  List<Evento> eventos;
  String tipo;

  @override
  void onInit() {
    tipo = INSCRITO;
    fetchEventos();
  }

  static Future<List<Evento>> getMeusEventos() async {
    meusEventos = null;
    var response = await EventosApi.getEventos(meus: true);
    if (response.ok) {
      meusEventos = response.result;
    } else {
      meusEventos = [];
    }
    return meusEventos;
  }

  static Future<List<Evento>> getTodosEventos() async {
    todosEventos = null;
    var response = await EventosApi.getEventos();
    if (response.ok) {
      todosEventos = response.result;
    } else {
      todosEventos = [];
    }
    return todosEventos;
  }

  fetchEventos() async {
    if (tipo == MEUS) {
      eventos = await getMeusEventos();
    } else {
      eventos = await getTodosEventos();
    }
    update();
    return;
  }

  static Future<Evento> getViagemById(int i) async {
    List<Evento> eventos = [];
    eventos.addAll(await getTodosEventos());
    eventos.addAll(await getMeusEventos());
    Evento eventoEncontrado;
    eventos.forEach((evento) {
      if (evento.id == i) {
        eventoEncontrado = evento;
      }
    });
    return eventoEncontrado;
  }
}
