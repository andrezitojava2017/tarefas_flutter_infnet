import 'package:flutter/material.dart';
import 'package:task_app/modelos/item.dart';

class EditarTarefa extends StatefulWidget {
  var iten = <Item>[];
  int indice;

  EditarTarefa({super.key, required this.iten, required this.indice});

  @override
  EditarTarefaState createState() => EditarTarefaState();
}

class EditarTarefaState extends State<EditarTarefa> {
  @override
  void initState() {
    Item trf = widget.iten[widget.indice];
    tarefa.text = trf.titulo;
    horario.text = trf.horario;
  }

  var tarefa = TextEditingController();
  var horario = TextEditingController();

  void alterarTarefa() {
    setState(() {
      widget.iten[widget.indice] =
          Item(titulo: tarefa.text, encerrado: false, horario: horario.text);
    });

    Navigator.pop(context, widget.iten);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar tarefa'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
                  child: TextFormField(
                    controller: tarefa,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Tarefa',
                    ),
                  ),
                ),
                TextFormField(
                  controller: horario,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Horario',
                  ),
                ),
                ElevatedButton(
                    onPressed: () => alterarTarefa(),
                    child: Text('Salvar alteração'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
