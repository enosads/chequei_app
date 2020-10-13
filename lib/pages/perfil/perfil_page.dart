import 'package:chequei/pages/login/login_page.dart';
import 'package:chequei/pages/perfil/editar_perfil_bottom_sheet.dart';
import 'package:chequei/pages/perfil/usuario_controller.dart';
import 'package:chequei/utils/date_utils.dart';
import 'package:chequei/utils/prefs.dart';
import 'package:chequei/widgets/app_card.dart';
import 'package:chequei/widgets/app_dialog.dart';
import 'package:chequei/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsuarioController>(
      builder: (_) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(_),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Chequei'),
              centerTitle: true,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Perfil') {
                      EditarPerfilBottomSheet.show();
                    } else if (value == 'Sair') {
                      _onClickSair(_);
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                  ),
                  tooltip: 'Mais opções',
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'Perfil',
                      child: Text('Editar perfil'),
                    ),
                    PopupMenuItem(
                      value: 'Sair',
                      child: Text('Sair'),
                    ),
                  ],
                )
              ],
            ),
            body: _body(_),
          ),
        );
      },
    );
  }

  _body(UsuarioController _) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2),
          _cardInformacoesPessoais(_),
          SizedBox(height: 2)
        ],
      ),
    );
  }

  Container _cardInformacoesPessoais(UsuarioController _) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: AppCard(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Tile(
                  title: TitleTile(
                    'Informações pessoais',
                    bold: true,
                  ),
                ),
                Tile(
                  leading: Icon(
                    Icons.person,
                  ),
                  title: TitleTile(
                    '${_.usuario.nome.value} (${_.usuario.username.value})',
                  ),
                  subtitle: 'Nome',
                ),
                Tile(
                    leading: Icon(
                      Icons.alternate_email,
                    ),
                    title: TitleTile(
                      _.usuario.email.value,
                    ),
                    subtitle: 'E-mail'),
                Tile(
                    leading: Icon(
                      Icons.phone,
                    ),
                    title: TitleTile(
                      _.usuario.telefone.value,
                    ),
                    subtitle: 'Telefone'),
                Tile(
                    leading: Icon(
                      Icons.assignment,
                    ),
                    title: TitleTile(
                      _.usuario.cpf.value,
                    ),
                    subtitle: 'CPF'),
                Tile(
                    leading: Icon(
                      Icons.event,
                    ),
                    title: TitleTile(DateUtil.format(_.usuario.dataNascimento.value)),
                    subtitle: 'Data de nascimento'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(UsuarioController _) async {
    return await _.getUsuario();
  }

  void _onClickSair(UsuarioController _) {
    AppDialog(
      Text('Deseja realmente sair?'),
      onCancel: () => {Get.back()},
      textConfirm: 'Sair',
      textCancel: 'Cancelar',
      confirmColor: Colors.red,
      onConfirm: () {
        Prefs.setString('lastLogin', _.usuario.username.value);
        _.clear();
        Get.back();
        Get.off(
          LoginPage(),
        );
      },
    ).show();
  }
}
