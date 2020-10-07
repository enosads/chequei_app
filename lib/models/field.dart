import 'package:chequei/models/erro_model.dart';

class Field<T> {
  T value;
  List<Erro> erros;

  Field({this.value, this.erros});
}
