import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/tarefa_provider.dart';
import 'package:task_app/modelos/item.dart';

class EditarTarefa extends StatelessWidget {
  final int index;
  final TextEditingController tituloController;
  final TextEditingController horarioController;

  EditarTarefa({super.key, required this.index})
      : tituloController = TextEditingController(),
        horarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tarefaProvider = Provider.of<TarefaProvider>(context);
    final tarefa = tarefaProvider.items[index];
    tituloController.text = tarefa.titulo!;
    horarioController.text = tarefa.horario!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: horarioController,
              decoration: const InputDecoration(
                labelText: 'Horário',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final novaTarefa = Item(
                  id: tarefa.id,
                  titulo: tituloController.text,
                  encerrado: tarefa.encerrado!,
                  horario: horarioController.text,
                );
                tarefaProvider.editarTarefa(
                  novaTarefa.id!,
                  novaTarefa,
                );
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
