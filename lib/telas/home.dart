import 'package:flutter/material.dart';
import 'package:task_app/telas/ediarTarefa.dart';
import 'package:task_app/telas/novaTarefa.dart';

import '../modelos/item.dart';

class Home extends StatefulWidget {
// ignore: deprecated_member_use, unnecessary_new, prefer_collection_literals
  var items = <Item>[];

  Home() {
    items = [];
    items.add(Item(titulo: 'Tarefa1', encerrado: false, horario: '10:25'));
    items.add(Item(titulo: 'Tarefa2', encerrado: true, horario: '10:25'));
    items.add(Item(titulo: 'Tarefa3', encerrado: false, horario: '10:25'));
    items.add(Item(titulo: 'Tarefa4', encerrado: true, horario: '10:25'));
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void removerItem(index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('lista de tarefas'),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.items[index].titulo),
                Container(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => removerItem(index),
                        child: Icon(Icons.delete),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarTarefa(
                                  iten: widget.items, indice: index),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              widget.items = result;
                            });
                          }
                        },
                        child: Icon(Icons.edit_document),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
          // return Text(widget.items[index].titulo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Tarefas(iten: widget.items),
            ),
          );
          if (result != null) {
            setState(() {
              widget.items = result;
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
