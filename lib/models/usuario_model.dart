class Usuario {
  int id;
  String username;
  String nome;
  String cpf;
  String telefone;
  String dataNascimento;
  String email;
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

  Usuario.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    nome = map['nome'];
    cpf = map['cpf'];
    telefone = map['telefone'];
    email = map['email'];
    dataNascimento = map['data_nascimento'];
    token = map['token'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['data_nascimento'] = this.dataNascimento;
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
