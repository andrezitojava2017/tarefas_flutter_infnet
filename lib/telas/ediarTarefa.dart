import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/tarefaProvider.dart';
import 'package:task_app/modelos/item.dart';

class EditarTarefa extends StatelessWidget {
  final int index;
  final TextEditingController tituloController;
  final TextEditingController horarioController;

  EditarTarefa({required this.index})
      : tituloController = TextEditingController(),
        horarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tarefaProvider = Provider.of<TarefaProvider>(context);
    final tarefa = tarefaProvider.items[index];
    tituloController.text = tarefa.titulo;
    horarioController.text = tarefa.horario;

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: horarioController,
              decoration: InputDecoration(
                labelText: 'Horário',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final novaTarefa = Item(
                  titulo: tituloController.text,
                  encerrado: tarefa.encerrado,
                  horario: horarioController.text,
                );
                tarefaProvider.editarTarefa(index, novaTarefa);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
