class Erro {
  String message;
  String code;

  Erro({this.message, this.code});

  Erro.fromMap(Map<String, dynamic> map) {
    message = map['message'];
    code = map['code'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}
