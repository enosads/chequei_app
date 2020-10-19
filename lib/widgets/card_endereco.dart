import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/widgets/app_card.dart';
import 'package:chequei/widgets/tile.dart';
import 'package:flutter/material.dart';

class CardEndereco extends StatelessWidget {
  Endereco endereco;

  CardEndereco(this.endereco);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Column(
          children: <Widget>[
            Tile(
              fittedTitle: true,
              leading: Icon(
                Icons.place,
              ),
              isThreeLine: true,
              title: TitleTile(endereco.getPrimeiraParte()),
              subtitle: endereco.getSegundaParte(),
            ),
          ],
        ),
      ),
    );
  }
}
