import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/tarefa_provider.dart';
import 'package:task_app/modelos/item.dart';
import 'package:task_app/telas/editar_tarefa.dart';
import 'package:task_app/telas/nova_tarefa.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TarefaProvider tarefaProvider;
  late Future<void> future;

  Future<void> escutarItens() async {
    FirebaseFirestore.instance.collection('tarefas').snapshots().listen((data) {
      tarefaProvider.items.clear();
      if (data.docs.isNotEmpty) {
        tarefaProvider.items.addAll(
          data.docs.map((e) => Item.fromJson(e.data(), e.id)).toList(),
        );
        tarefaProvider.atualizar();
      }
    });
  }

  Future<void> initScreen({String? query}) async {
    tarefaProvider = Provider.of<TarefaProvider>(context, listen: false);
    await escutarItens();
  }

  @override
  void initState() {
    super.initState();
    future = initScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return Consumer<TarefaProvider>(builder: (context, myProvider, _) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Lista de Tarefas'),
              ),
              body: ListView.builder(
                itemCount: tarefaProvider.items.length,
                itemBuilder: (context, index) {
                  final tarefa = tarefaProvider.items[index];
                  return ListTile(
                    title: Text(tarefa.titulo!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tarefa.horario!),
                        Text(tarefa.id!),
                      ],
                    ),
                    trailing: Checkbox(
                      value: tarefa.encerrado,
                      onChanged: (value) {
                        final novaTarefa = Item(
                          id: tarefa.id,
                          titulo: tarefa.titulo,
                          encerrado: value,
                          horario: tarefa.horario,
                        );
                        tarefaProvider.editarTarefa(
                          novaTarefa.id!,
                          novaTarefa,
                        );
                      },
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Opções'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Editar'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditarTarefa(index: index),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('Remover'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  tarefaProvider.removerTarefa(tarefa.id!);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NovaTarefa(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            );
          });
        });
  }
}
