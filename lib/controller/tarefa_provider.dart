import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/modelos/item.dart';

class TarefaProvider extends ChangeNotifier {
  final FirebaseFirestore firestore;
  TarefaProvider({required this.firestore});
  List<Item> items = [];

  void adicionarTarefa(Item tarefa) async {
    var value = tarefa.toJson();
    FirebaseFirestore.instance.collection('tarefas').add(value);
    // items.add(tarefa);
    notifyListeners();
  }

  void removerTarefa(String index) async {
    await FirebaseFirestore.instance.collection('tarefas').doc(index).delete();
    // items.removeAt(index);
    notifyListeners();
  }

  void editarTarefa(String index, Item tarefa) async {
    var value = tarefa.toJson();
    await FirebaseFirestore.instance
        .collection('tarefas')
        .doc(index)
        .update(value);
    // items[index] = novaTarefa;
    notifyListeners();
  }

  void atualizar() {
    notifyListeners();
  }
}
