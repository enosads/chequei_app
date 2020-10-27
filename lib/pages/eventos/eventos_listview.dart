import 'package:chequei/models/evento_model.dart';
import 'package:chequei/utils/date_utils.dart';
import 'package:chequei/widgets/app_card.dart';
import 'package:flutter/material.dart';

class EventoListView extends StatelessWidget {
  List<Evento> eventos;

  EventoListView(this.eventos);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        Evento evento = eventos[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: AppCard(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // Get.to(VagaPage(evento));
              },
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 8),
                        child: Text(
                          evento.descricao.value,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16,bottom: 8),
                        child: Text(
                          'Organização: ${evento.criador.nome.value}',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Text(
                          'Local: ${evento.endereco.cidade.value} - ${evento.endereco.estado.value}',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      '${DateUtil.format(evento.horario, )}\n${DateUtil.formatOnlyTime(evento.horario)}',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )

                ],
              ),
            ),
          ),
        );
      },
      itemCount: eventos.length,
    );
  }
}
