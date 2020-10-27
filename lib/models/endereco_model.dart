import 'package:chequei/models/erro_model.dart';
import 'package:chequei/models/field.dart';

class Endereco {
  int id;
  Field<String> cidade;
  Field<String> estado;
  Field<String> rua;
  Field<String> bairro;
  Field<String> cep;
  Field<String> numero;
  Field<String> complemento;

  Endereco(
      {this.id,
      this.cidade,
      this.rua,
      this.bairro,
      this.cep,
      this.numero,
      this.complemento,
      this.estado});

  Endereco.fromMap(Map<String, dynamic> map, {bool error = false}) {
    if (error) {
      print(map);
      if (map['rua'] != null) {
        rua = Field<String>(
            erros: map['rua'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['cidade'] != null) {
        cidade = Field<String>(
            erros:
                map['cidade'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['estado'] != null) {
        cidade = Field<String>(
            erros:
                map['cidade'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['bairro'] != null) {
        bairro = Field<String>(
            erros:
                map['bairro'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['cep'] != null) {
        cep = Field<String>(
            erros: map['cep'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['numero'] != null) {
        numero = Field<String>(
            erros:
                map['numero'].map<Erro>((map) => Erro.fromMap(map)).toList());
      }
      if (map['complemento'] != null) {
        complemento = Field<String>(
            erros: map['complemento']
                .map<Erro>((map) => Erro.fromMap(map))
                .toList());
      }
    } else {
      id = map['id'];

      rua = Field<String>(value: map['rua']);
      cidade = Field<String>(value: map['cidade']);
      estado = Field<String>(value: map['estado']);
      bairro = Field<String>(value: map['bairro']);
      cep = Field<String>(value: map['cep']);
      numero = Field<String>(value: map['numero']);
      complemento = Field<String>(value: map['complemento']);
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;

    data['rua'] = this.rua.value;
    data['cidade'] = this.cidade.value;
    data['estado'] = this.estado.value;
    data['bairro'] = this.bairro.value;
    data['cep'] = this.cep.value;
    data['numero'] = this.numero.value;
    data['complemento'] = this.complemento.value;
    return data;
  }

  String getPrimeiraParte() {
    return '${rua.value},'
        ' ${numero.value}';
  }

  String getSegundaParte() {
    return '${bairro.value}, ${cidade.value} - ${estado.value}\n'
        '${complemento.value != null && complemento.value.isNotEmpty ? complemento.value : ''}'
        '${complemento.value != null && complemento.value.isNotEmpty ? ' - ' : ''}${cep.value}';
  }

  static List<String> getEstados() {
    return [
      ACRE,
      AMAPA,
      ALAGOAS,
      AMAZONAS,
      BAHIA,
      CEARA,
      DISTRITO_FEDERAL,
      ESPIRITO_SANTO,
      GOIAS,
      MARANHAO,
      MATO_GROSSO,
      MATO_GROSSO_DO_SUL,
      MINAS_GERAIS,
      PARA,
      PARAIBA,
      PARANA,
      PERNAMBUCO,
      PIAUI,
      RIO_DE_JANEIRO,
      RIO_GRANDE_DO_NORTE,
      RIO_GRANDE_DO_SUL,
      RONDONIA,
      RORAIMA,
      SANTA_CATARINA,
      SAO_PAULO,
      SERGIPE,
      TOCANTINS
    ];
  }

  static const String ACRE = 'AC';
  static const String AMAPA = 'AP';
  static const String ALAGOAS = 'AL';
  static const String AMAZONAS = 'AM';
  static const String BAHIA = 'BA';
  static const String CEARA = 'CE';
  static const String DISTRITO_FEDERAL = 'DF';
  static const String ESPIRITO_SANTO = 'ES';
  static const String GOIAS = 'GO';
  static const String MARANHAO = 'MA';
  static const String MATO_GROSSO = 'MT';
  static const String MATO_GROSSO_DO_SUL = 'MS';
  static const String MINAS_GERAIS = 'MG';
  static const String PARA = 'PA';
  static const String PARAIBA = 'PB';
  static const String PARANA = 'PR';
  static const String PERNAMBUCO = 'PE';
  static const String PIAUI = 'PI';
  static const String RIO_DE_JANEIRO = 'RJ';
  static const String RIO_GRANDE_DO_NORTE = 'RN';
  static const String RIO_GRANDE_DO_SUL = 'RS';
  static const String RONDONIA = 'RO';
  static const String RORAIMA = 'RR';
  static const String SANTA_CATARINA = 'SC';
  static const String SAO_PAULO = 'SP';
  static const String SERGIPE = 'SE';
  static const String TOCANTINS = 'TO';
}
