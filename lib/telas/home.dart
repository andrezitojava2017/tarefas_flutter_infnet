import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/tarefaProvider.dart';
import 'package:task_app/modelos/item.dart';
import 'package:task_app/telas/ediarTarefa.dart';
import 'package:task_app/telas/novaTarefa2.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Consumer<TarefaProvider>(
        builder: (context, tarefaProvider, _) {
          return ListView.builder(
            itemCount: tarefaProvider.items.length,
            itemBuilder: (context, index) {
              final tarefa = tarefaProvider.items[index];
              return ListTile(
                title: Text(tarefa.titulo),
                subtitle: Text(tarefa.horario),
                trailing: Checkbox(
                  value: tarefa.encerrado,
                  onChanged: (value) {
                    final novaTarefa = Item(
                      titulo: tarefa.titulo,
                      encerrado: value ?? false,
                      horario: tarefa.horario,
                    );
                    tarefaProvider.editarTarefa(index, novaTarefa);
                  },
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Opções'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Editar'),
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
                            child: Text('Remover'),
                            onPressed: () {
                              Navigator.pop(context);
                              tarefaProvider.removerTarefa(index);
                            },
                          ),
                        ],
                      );
                    },
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
              builder: (context) => NovaTarefa(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
