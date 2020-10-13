import 'package:chequei/models/erro_model.dart';
import 'package:chequei/models/field.dart';

class Usuario {
  int id;
  Field<String> username;
  Field<String> nome;
  Field<String> cpf;
  Field<String> telefone;
  Field<DateTime> dataNascimento;
  Field<String> email;
  String token;

  Usuario({
    this.id,
    this.username,
    this.nome,
    this.cpf,
    this.telefone,
    this.email,
    this.dataNascimento,
    this.token,
  });

  Usuario.fromMap(Map<String, dynamic> map, {bool error = false}) {
    if (error) {
      if (map['email'] != null) {
        email = Field<String>(
            erros: map['email'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['nome'] != null) {
        nome = Field<String>(
            erros: map['nome'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['telefone'] != null) {
        telefone = Field<String>(
            erros:
                map['telefone'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['cpf'] != null) {
        cpf = Field<String>(
            erros: map['cpf'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['user'] != null) {
        if (map['user']['username'] != null) {
          username = Field<String>(
              erros: map['user']['username']
                  .map<Erro>((map) => Erro.fromMap(map))
                  .toList());
        }
      }
    } else {
      id = map['id'];
      username = Field<String>(value: map['username']);
      nome = Field<String>(value: map['nome']);
      cpf = Field<String>(value: map['cpf']);
      telefone = Field<String>(value: map['telefone']);
      email = Field<String>(value: map['email']);
      dataNascimento =
          Field<DateTime>(value: DateTime.parse(map['data_nascimento']));
      token = map['token'];
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username.value;
    data['data_nascimento'] = this.dataNascimento.toString();
    data['nome'] = this.nome.value;
    data['cpf'] = this.cpf.value;
    data['telefone'] = this.telefone.value;
    data['email'] = this.email.value;
    data['token'] = this.token;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{id: $id, username: $username, nome: $nome, cpf: $cpf, telefone: $telefone, dataNascimento: $dataNascimento, email: $email}';
  }
}
