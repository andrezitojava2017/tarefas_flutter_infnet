class Item {
  String titulo;
  bool encerrado;
  String horario;

  Item({required this.titulo, required this.encerrado, required this.horario});

  fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    encerrado = json['encerrado'];

    horario = json['horario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['enerrado'] = this.encerrado;
    data['horario'] = this.horario;
    return data;
  }
}
