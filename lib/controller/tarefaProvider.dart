import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:task_app/modelos/item.dart';

class TarefaProvider extends ChangeNotifier {
  List<Item> items = [];

  TarefaProvider() {
    items.add(Item(titulo: 'Tarefa1', encerrado: false, horario: '10:25'));
    items.add(Item(titulo: 'Tarefa2', encerrado: true, horario: '10:25'));
    items.add(Item(titulo: 'Tarefa3', encerrado: false, horario: '10:25'));
    items.add(Item(titulo: 'Tarefa4', encerrado: true, horario: '10:25'));
  }

  void adicionarTarefa(Item tarefa) {
    items.add(tarefa);
    notifyListeners();
  }

  void removerTarefa(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void editarTarefa(int index, Item novaTarefa) {
    items[index] = novaTarefa;
    notifyListeners();
  }
}
