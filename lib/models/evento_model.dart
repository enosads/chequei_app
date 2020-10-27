import 'package:chequei/models/endereco_model.dart';
import 'package:chequei/models/erro_model.dart';
import 'package:chequei/models/field.dart';
import 'package:chequei/models/usuario_model.dart';

class Evento {
  int id;
  Endereco endereco;
  Field<String> descricao;
  DateTime horario;
  Usuario criador;
  String codigo;
  Field<int> quantidadeDeVagas;

  Evento(
      {this.id,
      this.endereco,
      this.descricao,
      this.horario,
      this.codigo,
      this.quantidadeDeVagas,
      this.criador});

  Evento.fromMap(Map<String, dynamic> map, {bool error = false}) {
    if (error) {
      if (map['descricao'] != null) {
        descricao = Field<String>(
            erros: map['descricao']
                .map<Erro>((map) => Erro.fromMap(map))
                .toList());
      }
      if (map['quantidade_de_vagas'] != null) {
        quantidadeDeVagas = Field<int>(
            erros: map['quantidade_de_vagas']
                .map<Erro>((map) => Erro.fromMap(map))
                .toList());
      }
    } else {
      id = map['id'];
      endereco =
          map['endereco'] != null ? Endereco.fromMap(map['endereco']) : null;
      criador = map['criador'] != null ? Usuario.fromMap(map['criador']) : null;
      descricao = Field<String>(value:  map['descricao']);
      horario = DateTime.parse(map['horario']);
      codigo = map['codigo'];
      quantidadeDeVagas = Field<int>(value:  map['quantidade_de_vagas']);

    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.endereco != null) {
      data['endereco'] = this.endereco.toMap();
    }
    if (this.criador != null) {
      data['criador'] = this.criador.toMap();
    }
    data['descricao'] = this.descricao.value;
    data['horario'] = this.horario.toString();
    data['codigo'] = this.codigo;
    data['quantidade_de_vagas'] = this.quantidadeDeVagas.value;
    data['criador'] = this.criador;
    return data;
  }
}
