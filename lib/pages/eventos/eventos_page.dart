import 'package:chequei/pages/eventos/eventos_controller.dart';
import 'package:chequei/pages/eventos/eventos_listview.dart';
import 'package:chequei/pages/eventos/novo_evento_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventosController>(
      init: EventosController(),
      builder: (_) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(_),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Chequei'),
              actions: [
                PopupMenuButton(
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          _.tipo,
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Meus'),
                      value: 'Meus',
                    ),
                    PopupMenuItem(
                      child: Text('Inscrito'),
                      value: 'Inscrito',
                    )
                  ],
                  onSelected: (value) {
                    if (value == 'Meus') {
                      _.tipo = EventosController.MEUS;
                    } else {
                      _.tipo = EventosController.INSCRITO;
                    }
                    _.fetchEventos();
                  },
                ),
              ],
            ),
            body: _body(_),
            floatingActionButton: FloatingActionButton(
              onPressed: () => NovoEventoBottomSheet.show(),
              child: Icon(Icons.add),

            ),

          ),
        );
      },
    );
  }

  _body(EventosController _) {
    return _.eventos == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _.eventos.isEmpty
            ? GestureDetector(
                onTap: () => _onRefresh(_),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _.tipo == EventosController.INSCRITO
                            ? 'Nenhum evento encontrado'
                            : 'Você ainda não criou nenhum evento.',
                      ),
                      Text(
                        'toque para atualizar',
                      ),
                    ],
                  ),
                ),
              )
            : EventoListView(_.eventos);
  }

  Future<void> _onRefresh(EventosController _) async {
    return await _.fetchEventos();
  }
}
