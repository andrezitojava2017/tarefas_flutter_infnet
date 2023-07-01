class Item {
  String? id;
  String? titulo;
  bool? encerrado;
  String? horario;

  Item({
    this.id,
    required this.titulo,
    required this.encerrado,
    required this.horario,
  });

  Item.fromJson(Map<String, dynamic> json, String fireId) {
    id = fireId;
    titulo = json['titulo'];
    encerrado = json['encerrado'];
    horario = json['horario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    data['encerrado'] = encerrado ?? false;
    data['horario'] = horario;
    return data;
  }
}
