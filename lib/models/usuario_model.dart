import 'package:chequei/models/field.dart';

class Usuario {
  int id;
  String username;
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
    } else {
      id = map['id'];
      username = map['username'];
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
    data['username'] = this.username;
    data['data_nascimento'] = this.dataNascimento.toString();
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['telefone'] = this.telefone;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{id: $id, username: $username, nome: $nome, cpf: $cpf, telefone: $telefone, dataNascimento: $dataNascimento, email: $email}';
  }
}
